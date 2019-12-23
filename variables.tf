#################
# Provider
#################

variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
}

#################
# Security group
#################

variable "create" {
  description = "Whether to create security group, If set `false` you must set `existing_group_id`."
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
  description = "ID of existing security group. If set, you should specify `create` as false to avoid creating redundant security group. (If this field has been set, you can set `create` to false at any time.)"
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
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

variable "ingress_with_cidr_block" {
  description = "List of ingress rules to create where `cidr_block` is used. Each item's `cidr_block` can not be empty.  If some one item want to use `cidr_blocks`, the first one of `cidr_blocks` will be used."
  type        = list(map(string))
  default     = []
}
variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_block' is not used. Each item's `cidr_block` will be ignored."
  type        = list(map(string))
  default     = []
}
variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where `source_security_group_id` is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_ports" {
  description = "The port list to use on all ingress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}
variable "protocol_for_ingress_with_ports" {
  description = "The default protocol where `ingress_with_ports` is used"
  type        = string
  default     = "tcp"
}

variable "priority_for_ingress_with_ports" {
  description = "A priority is used when setting `ingress_with_ports`. Default to `default_ingress_priority`."
  type        = number
  default     = 1
}

variable "ingress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on ingress cidrs rules. It's length up to 20 and more items will be ignored."
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

variable "egress_with_cidr_block" {
  description = "List of egress rules to create where `cidr_block` is used. Each item's `cidr_block` can not be empty. If some one item want to use `cidr_blocks`, the first one of `cidr_blocks` will be used."
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_block' is not used. Each item's `cidr_block` will be ignored."
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_ports" {
  description = "The port list to use on all egress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}

variable "protocol_for_egress_with_ports" {
  description = "A protocol where `egress_with_ports` is used."
  type        = string
  default     = "tcp"
}

variable "priority_for_egress_with_ports" {
  description = "A priority is used when setting `egress_with_ports`. Default to `default_egress_priority`."
  type        = number
  default     = 1
}

variable "egress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on egress cidrs rules. It's length up to 20 and more items will be ignored."
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
  description = "(Deprecated) It has been deprecated from 1.6.0, and use `name` instead."
  default     = ""
}
variable "vpc_name" {
  description = "(Deprecated) It has been deprecated from 1.6.0."
  default     = ""
}

variable "vpc_cidr" {
  description = "(Deprecated) It has been deprecated from 1.6.0."
  default     = ""
}

variable "group_id" {
  description = "(Deprecated) It has been deprecated from 1.6.0, and use `existing_group_id` instead."
  default     = ""
}

variable "group_name" {
  description = "(Deprecated) It has been deprecated from 1.6.0 and use 'name' instead."
  default     = ""
}

variable "group_description" {
  description = "(Deprecated) It has been deprecated from 1.6.0 and use 'name' instead."
  default     = ""
}

variable "protocol" {
  description = "(Deprecated) It has been deprecated from 1.6.0, and use `protocol_for_ingress_with_ports` and `protocol_for_egress_with_ports` instead."
  type        = string
  default     = "tcp"
}

variable "priority" {
  description = "(Deprecated) It has been deprecated from 1.6.0, and use `default_ingress_priority` and `default_egress_priority` instead."
  type        = number
  default     = 1
}