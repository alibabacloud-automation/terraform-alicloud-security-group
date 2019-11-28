#################
# Security group
#################
variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
}

variable "group_name" {
  description = "Name of security group"
  type        = string
}

variable "group_description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
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


variable "priority" {
  description = "The security group rules priority used to set one or more rules."
  type        = number
  default     = 1
}


