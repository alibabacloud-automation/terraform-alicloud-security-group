variable "create" {
  description = "Whether to create security group rules"
  default     = false
}
variable "group_id" {
  description = "ID of existing security group."
  default     = ""
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  # Protocols (tcp, udp, icmp, all - are allowed keywords) or numbers (from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml):
  default = {}
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
  description = "The priority where `ingress_rules` is used"
  type        = number
  default     = 1
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where `cidr_block` is not used. Each item's `cidr_block` will be ignored."
  type        = list(map(string))
  default     = []
}

variable "ingress_cidr_block" {
  description = "IPv4 CIDR ranges to use on all ingress rules"
  type        = string
  default     = ""
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

variable "default_ingress_priority" {
  description = "A default priority for an ingress rule."
  type        = number
  default     = 50
}

##########
# egress
##########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}
variable "priority_for_egress_rules" {
  description = "The priority where `egress_rules` is used"
  type        = number
  default     = 1
}
variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where `cidr_block` is not used. Each item's `cidr_block` will be ignored."
  type        = list(map(string))
  default     = []
}

variable "egress_cidr_block" {
  description = "IPv4 CIDR ranges to use on all egress rules"
  type        = string
  default     = ""
}

variable "egress_with_ports" {
  description = "The port list to use on all egress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}

variable "protocol_for_egress_with_ports" {
  description = "The default protocol where `egress_with_ports` is used"
  type        = string
  default     = "tcp"
}

variable "priority_for_egress_with_ports" {
  description = "A priority is used when setting `egress_with_ports`. Default to `default_egress_priority`."
  type        = number
  default     = 1
}

variable "default_egress_priority" {
  description = "A default priority for an egress rule."
  type        = number
  default     = 50
}