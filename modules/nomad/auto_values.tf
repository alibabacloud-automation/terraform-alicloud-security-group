# This file was generated from values defined in rules.tf using update_groups.sh.
###################################
# DO NOT CHANGE THIS FILE MANUALLY
###################################

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = ["nomad-http-tcp", "nomad-rpc-tcp", "nomad-serf-tcp", "nomad-serf-udp"]
}

variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = list(string)
  default     = ["all-all"]
}


