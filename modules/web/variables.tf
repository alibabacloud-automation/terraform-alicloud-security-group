#################
# Provider
#################



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

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = ["http-80-tcp", "http-8080-tcp", "https-443-tcp", "web-jmx-tcp"]
}

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
variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = list(string)
  default     = ["all-all"]
}

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


variable "ingress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_ports` instead. The port list to use on all ingress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}

variable "egress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_ports` instead. The port list to use on all egress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}

