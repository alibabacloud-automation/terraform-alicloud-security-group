variable "group_id" {
  description = "ID of existing security group."
  default     = ""
}

##########
# egress
##########
variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  # Protocols (tcp, udp, icmp, all - are allowed keywords) or numbers (from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml):
  default = {}
}

variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_block" {
  description = "List of egress rules to create where 'egress_cidr_block' is not used. Each element's `cidr_block` can not be empty."
  type        = list(map(string))
  default     = []
}
variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'egress_cidr_block' is used. Each element's `cidr_block` will be ignored."
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
  default     = ""
}

variable "egress_with_ports" {
  description = "The port list to use on all egress ports rules, from port and to port is same in this way."
  type        = list(number)
  default     = []
}

variable "protocol_for_egress_with_ports" {
  description = "The default protocol when setting egress_with_ports"
  type        = string
  default     = "tcp"
}

variable "priority_for_egress_rules" {
  description = "The priority of an egress rule."
  type        = number
  default     = 1
}

variable "default_priority" {
  description = "The priority of an egress rule."
  type        = number
  default     = 50
}