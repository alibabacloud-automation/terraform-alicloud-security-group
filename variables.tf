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


variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "create_vpc" {
  description = "Whether to create a new vpc used to create security group and rules."
  type        = bool
  default     = false
}

variable "default_protocol" {
  description = "The default protocol used to create rules, supported values: 'tcp', 'udp', 'gre', 'icmp' and 'all'."
  default     = "all"
}

variable "this_module_name" {
  default = "terraform-alicloud-security-group"
}

##########
# Ingress
##########

variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "ingress_with_cidr_block" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_cidr_block" {
  description = "IPv4 CIDR ranges to use on all ingress rules"
  type        = string
  default     = ""
}

variable "ingress_ports" {
  description = "The port list to use on all ingress ports rules, from port and to port is same in this way."
  type        = list(number)
  default     = []
}

variable "ingress_cidrs" {
  description = "The IPv4 CIDR ranges list to use on ingress cidrs rules"
  type        = list(string)
  default     = []
}

variable "ingress_port_with_cidrs" {
  description = "IPv4 CIDR ranges to use on ingress cidrs rules, from port and to port is same in this way."
  type        = number
  default     = 0
}

#########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_block" {
  description = "List of egress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "egress_cidr_block" {
  description = "IPv4 CIDR ranges to use on all egress rules"
  type        = string
  default     = "0.0.0.0/0"
}

variable "egress_ports" {
  description = "The port list to use on all egress ports rules, from port and to port is same in this way."
  type        = list(number)
  default     = []
}

variable "egress_cidrs" {
  description = "The IPv4 CIDR ranges list to use on egress cidrs rules"
  type        = list(string)
  default     = []
}

variable "egress_port_with_cidrs" {
  description = "IPv4 CIDR ranges to use on egress cidrs rules, from port and to port is same in this way."
  type        = number
  default     = 0
}



# VPC variables
variable "vpc_name" {
  description = "The vpc name used to create a new vpc when 'vpc_id' is not specified. Default to variable `this_module_name`"
  default     = ""
}

variable "vpc_id" {
  description = "A existing vpc id used to create security group."
  default     = ""
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
  default     = "10.1.0.0/21"
}

# Security Group variables
variable "group_id" {
  description = "The security group id used to launch its rules."
  default     = ""
}

variable "group_name" {
  description = "The security group name used to launch a new security group when 'group_id' is not specified. Default to `this_module_name`"
  default     = ""
}

variable "group_description" {
  description = "The security group descripton used to launch a new security group when 'group_id' is not specified. Default to `TF_Security_Group`."
  default     = "TF_Security_Group"
}

variable "priority" {
  description = "The security group rules priority used to set one or more rules."
  type        = number
  default     = 1
}