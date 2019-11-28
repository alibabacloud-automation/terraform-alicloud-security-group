# This file was generated from values defined in rules.tf using update_groups.sh.
###################################
# DO NOT CHANGE THIS FILE MANUALLY
###################################

variable "auto_ingress_rules" {
  description = "List of ingress rules to add automatically"
  type        = list(string)
  default     = ["consul-tcp", "consul-cli-rpc-tcp", "consul-webui-tcp", "consul-dns-tcp", "consul-dns-udp", "consul-serf-lan-tcp", "consul-serf-lan-udp", "consul-serf-wan-tcp", "consul-serf-wan-udp"]
}

variable "auto_egress_rules" {
  description = "List of egress rules to add automatically"
  type        = list(string)
  default     = ["all-all"]
}


