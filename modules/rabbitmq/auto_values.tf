# This file was generated from values defined in rules.tf using update_groups.sh.
###################################
# DO NOT CHANGE THIS FILE MANUALLY
###################################

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = ["rabbitmq-4369-tcp", "rabbitmq-5671-tcp", "rabbitmq-5672-tcp", "rabbitmq-15672-tcp", "rabbitmq-25672-tcp"]
}

variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = list(string)
  default     = ["all-all"]
}


