#################
# Provider
#################

variable "region" {
  description = "(Deprecated from version 2.4.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 2.4.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "(Deprecated from version 2.4.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 2.4.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

#################
# Security group
#################

variable "create" {
  description = "Whether to create security group. If false, you can specify an existing security group by setting `existing_group_id`."
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of security group. It is used to create a new security group. A random name prefixed with 'terraform-sg-' will be set if it is empty."
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "existing_group_id" {
  description = "ID of existing security group. If set, the `create` will be ignored."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

variable "security_group_type" {
  description = "The type of the security group. Valid values: 'normal'(basic security group.), 'enterprise'(advanced security group For more information.). Default to 'normal'."
  type        = string
  default     = "normal"
}

##########
# Ingress
##########

variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "priority_for_ingress_rules" {
  description = "A priority is used when setting `ingress_rules`. Default to `default_ingress_priority`."
  type        = number
  default     = 1
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used. The valid keys contains `cidr_blocks`, `from_port`, `to_port`, `protocol`, `description`, `priority` and `rule`."
  type        = list(map(string))
  default     = []
}
variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where `source_security_group_id` is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_cidr_blocks_and_ports" {
  description = "List of ingress rules to create where `cidr_blocks` and `ports` is used. The valid keys contains `cidr_blocks`, `ports`, `protocol`, `description` and `priority`. The ports item's `from` and `to` have the same port. Example: '80,443' means 80/80 and 443/443."
  type        = list(map(string))
  default     = []
}
variable "ingress_ports" {
  description = "The port list used on `ingress_with_cidr_blocks_and_ports` ports rules."
  type        = list(number)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on ingress cidrs rules."
  type        = list(string)
  default     = []
}

variable "default_ingress_priority" {
  description = "A default ingress priority."
  type        = number
  default     = 50
}

#########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}
variable "priority_for_egress_rules" {
  description = "A priority where `egress_rules` is used. Default to `default_egress_priority`."
  type        = number
  default     = 1
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used. The valid keys contains `cidr_blocks`, `from_port`, `to_port`, `protocol`, `description` and `priority`."
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks_and_ports" {
  description = "List of egress rules to create where `cidr_blocks` and `ports` is used. The valid keys contains `cidr_blocks`, `ports`, `protocol`, `description` and `priority`. The ports item's `from` and `to` have the same port. Example: '80,443' means 80/80 and 443/443."
  type        = list(map(string))
  default     = []
}
variable "egress_ports" {
  description = "The port list used on `egress_with_cidr_blocks_and_ports` ports rules."
  type        = list(number)
  default     = []
}

variable "egress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on egress cidrs rules."
  type        = list(string)
  default     = []
}

variable "default_egress_priority" {
  description = "A default egress priority."
  type        = number
  default     = 50
}

# Deprecated variables
variable "this_module_name" {
  description = "(Deprecated) It has been deprecated from 2.0.0, and use `name` instead."
  default     = ""
}
variable "vpc_name" {
  description = "(Deprecated) It has been deprecated from 2.0.0."
  default     = ""
}

variable "vpc_cidr" {
  description = "(Deprecated) It has been deprecated from 2.0.0."
  default     = ""
}

variable "group_id" {
  description = "(Deprecated) It has been deprecated from 2.0.0, and use `existing_group_id` instead."
  default     = ""
}

variable "group_name" {
  description = "(Deprecated) It has been deprecated from 2.0.0 and use 'name' instead."
  default     = ""
}

variable "group_description" {
  description = "(Deprecated) It has been deprecated from 2.0.0 and use 'name' instead."
  default     = ""
}

variable "protocol" {
  description = "(Deprecated) It has been deprecated from 2.0.0, and use `protocol_for_ingress_with_ports` and `protocol_for_egress_with_ports` instead."
  type        = string
  default     = "tcp"
}

variable "priority" {
  description = "(Deprecated) It has been deprecated from 2.0.0, and use `default_ingress_priority` and `default_egress_priority` instead."
  type        = number
  default     = 1
}
variable "ingress_with_cidr_block" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_with_cidr_blocks` instead. List of ingress rules to create where `cidr_block` is used. Each item's `cidr_block` can not be empty.  If some one item want to use `cidr_blocks`, the first one of `cidr_blocks` will be used."
  type        = list(map(string))
  default     = []
}
variable "ingress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_ports` instead. The port list to use on all ingress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}
variable "protocol_for_ingress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_with_cidr_blocks_and_ports` instead. The default protocol where `ingress_with_ports` is used"
  type        = string
  default     = "tcp"
}
variable "priority_for_ingress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_with_cidr_blocks_and_ports` instead. A priority is used when setting `ingress_with_ports`. Default to `default_ingress_priority`."
  type        = number
  default     = 1
}
variable "egress_with_cidr_block" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_with_cidr_blocks` instead. List of egress rules to create where `cidr_block` is used. Each item's `cidr_block` can not be empty. If some one item want to use `cidr_blocks`, the first one of `cidr_blocks` will be used."
  type        = list(map(string))
  default     = []
}

variable "egress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_ports` instead. The port list to use on all egress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}
variable "protocol_for_egress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_with_cidr_blocks_and_ports` instead. A protocol where `egress_with_ports` is used."
  type        = string
  default     = "tcp"
}

variable "priority_for_egress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_with_cidr_blocks_and_ports` instead. A priority is used when setting `egress_with_ports`. Default to `default_egress_priority`."
  type        = number
  default     = 1
}