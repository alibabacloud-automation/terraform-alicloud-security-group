#!/usr/bin/env bash

# This script generates each public module (eg, "http-80", "ssh") and specify rules required for each group.
# This script should be run after rules.tf is changed to refresh all related modules.
# outputs.tf and variables.tf for all group modules are the same for all

set -e

# Change location to the directory where this script it located
cd "$(dirname "${BASH_SOURCE[0]}")"

check_dependencies() {
  if [[ ! $(command -v sed) ]]; then
    echo "ERROR: The binary 'sed' is required by this script but is not installed or in the system's PATH."
    echo "Check documentation: https://www.gnu.org/software/sed/"
    exit 1
  fi

  if [[ ! $(command -v json2hcl) ]]; then
    echo "ERROR: The binary 'json2hcl' is required by this script but is not installed or in the system's PATH."
    echo "Check documentation: https://github.com/kvz/json2hcl"
    exit 1
  fi

  if [[ ! $(command -v jq) ]]; then
    echo "ERROR: The binary 'jq' is required by this script but is not installed or in the system's PATH."
    echo "Check documentation: https://github.com/stedolan/jq"
    exit 1
  fi
}

auto_groups_data() {
  # Removing line with "type" because it json2hcl works with HCL1 only (ref https://github.com/kvz/json2hcl/issues/12)
  sed '/type/ d' rules.tf | json2hcl -reverse | jq -r '..|.auto_groups?|values|.[0]|.default|.[0]'
}

auto_groups_keys() {
  local data=$1

  echo "$data" | jq -r ".|keys|@sh" | tr -d "'"
}

get_auto_value() {
  local data=$1
  local group=$2
  local var=$3

  echo "$data" | jq -rc '.[$group][0][$var]' --arg group "$group" --arg var "$var"
}

set_list_if_null() {
  if [[ "null" == "$1" ]]; then
    echo "[]"
  else
    echo "$1"
  fi
}

set_zero_if_null() {
  if [[ "null" == "$1" ]]; then
    echo 0
  else
    echo "$1"
  fi
}

main() {
  check_dependencies

  readonly local auto_groups_data="$(auto_groups_data)"

  if [[ -z "$(auto_groups_data)" ]]; then
    echo "There are no modules to update. Check values of auto_groups inside rules.tf"
    exit 0
  fi

  readonly local auto_groups_keys=($(auto_groups_keys "$auto_groups_data"))

  local ingress_rules=""
  local egress_rules=""
  local list_of_modules=""

  for group in "${auto_groups_keys[@]}"; do

    echo "Making group: $group"

    mkdir -p "modules/$group"
    cp modules/_templates/{main,outputs,variables}.tf "modules/$group"

    # Get group values
    ingress_rules=$(get_auto_value "$auto_groups_data" "$group" "ingress_rules")
    egress_rules=$(get_auto_value "$auto_groups_data" "$group" "egress_rules")

    # Set to empty lists, if no value was specified
    ingress_rules=$(set_list_if_null "$ingress_rules")
    egress_rules=$(set_list_if_null "$egress_rules")

    cat <<EOF > "modules/$group/auto_values.tf"
# This file was generated from values defined in rules.tf using update_groups.sh.
###################################
# DO NOT CHANGE THIS FILE MANUALLY
###################################

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = $ingress_rules
}

variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = list(string)
  default     = $egress_rules
}


EOF

    cat <<EOF > "modules/$group/README.md"
# $group - Alicloud Security Group Terraform module

## Usage

\`\`\`hcl
module "${group/-/_}_security_group" {
  source  = "terraform-alicloud-modules/security-group/modules/${group}"

  # omitted...
}
\`\`\`

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
EOF

    list_of_modules=$(echo "$list_of_modules";  echo "* [$group](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/$group)")

    terraform fmt "modules/$group"
  done


  echo "Updating list of security group modules"

  cat <<EOF > modules/README.md
List of Security Groups implemented as Terraform modules
========================================================

$list_of_modules
* [_templates](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/_templates) - Source templates for all other modules. Change carefully, test thoughtfully!

EOF

  echo "Done!"
}

main
