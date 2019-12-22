// Security Group Ingress Rules for Module
###################################
# Ingress - List of rules (simple)
###################################
resource "alicloud_security_group_rule" "ingress_rules" {
  count             = var.create && var.ingress_cidr_block != "" ? length(var.ingress_rules) : 0
  type              = "ingress"
  ip_protocol       = var.rules[var.ingress_rules[count.index]][2]
  nic_type          = "intranet"
  port_range        = "${var.rules[var.ingress_rules[count.index]][0]}/${var.rules[var.ingress_rules[count.index]][1]}"
  security_group_id = var.group_id
  cidr_ip           = var.ingress_cidr_block
  priority          = var.priority_for_ingress_rules > 0 ? var.priority_for_ingress_rules : var.default_ingress_priority
  description       = var.rules[var.ingress_rules[count.index]][3]
}
##########################
# Ingress - Maps of rules and each item without cidr_block
##########################
resource "alicloud_security_group_rule" "ingress_with_cidr_blocks" {
  count             = var.create && var.ingress_cidr_block != "" ? length(var.ingress_with_cidr_blocks) : 0
  type              = "ingress"
  ip_protocol       = lookup(var.ingress_with_cidr_blocks[count.index], "protocol", var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.ingress_with_cidr_blocks[count.index], "from_port", var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][0], )}/${lookup(var.ingress_with_cidr_blocks[count.index], "to_port", var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id
  cidr_ip           = var.ingress_cidr_block
  priority          = lookup(var.ingress_with_cidr_blocks[count.index], "priority", var.default_ingress_priority)
  description       = lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")
}
##########################
# Ingress - Using a list of ports
##########################
resource "alicloud_security_group_rule" "ingress_with_ports" {
  count             = var.create && var.ingress_cidr_block != "" ? length(var.ingress_with_ports) : 0
  type              = "ingress"
  ip_protocol       = var.protocol_for_ingress_with_ports
  nic_type          = "intranet"
  port_range        = "${var.ingress_with_ports[count.index]}/${var.ingress_with_ports[count.index]}"
  security_group_id = var.group_id
  cidr_ip           = var.ingress_cidr_block
  priority          = var.priority_for_ingress_with_ports > 0 ? var.priority_for_ingress_with_ports : var.default_ingress_priority
  description       = "Ingress Rule"
}

// Security Group Egress Rules for Module
###################################
# Egress - List of rules (simple)
###################################
resource "alicloud_security_group_rule" "egress_rules" {
  count             = var.create && var.egress_cidr_block != "" ? length(var.egress_rules) : 0
  type              = "egress"
  ip_protocol       = var.rules[var.egress_rules[count.index]][2]
  nic_type          = "intranet"
  port_range        = "${var.rules[var.egress_rules[count.index]][0]}/${var.rules[var.egress_rules[count.index]][1]}"
  security_group_id = var.group_id
  cidr_ip           = var.egress_cidr_block
  priority          = var.priority_for_egress_rules > 0 ? var.priority_for_egress_rules : var.default_egress_priority
  description       = var.rules[var.egress_rules[count.index]][3]
}
##########################
# Egress - Maps of rules and each item without cidr_block
##########################
resource "alicloud_security_group_rule" "egress_with_cidr_blocks" {
  count             = var.create && var.egress_cidr_block != "" ? length(var.egress_with_cidr_blocks) : 0
  type              = "egress"
  ip_protocol       = lookup(var.egress_with_cidr_blocks[count.index], "protocol", var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.egress_with_cidr_blocks[count.index], "from_port", var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][0], )}/${lookup(var.egress_with_cidr_blocks[count.index], "to_port", var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id
  cidr_ip           = var.egress_cidr_block
  priority          = lookup(var.egress_with_cidr_blocks[count.index], "priority", var.default_egress_priority)
  description       = lookup(var.egress_with_cidr_blocks[count.index], "description", "Egress Rule")
}
##########################
# Egress - Using a list of ports
##########################
resource "alicloud_security_group_rule" "egress_with_ports" {
  count             = var.create && var.egress_cidr_block != "" ? length(var.egress_with_ports) : 0
  type              = "egress"
  ip_protocol       = var.protocol_for_egress_with_ports
  nic_type          = "intranet"
  port_range        = "${var.egress_with_ports[count.index]}/${var.egress_with_ports[count.index]}"
  security_group_id = var.group_id
  cidr_ip           = var.egress_cidr_block
  priority          = var.priority_for_egress_with_ports > 0 ? var.priority_for_egress_with_ports : var.default_egress_priority
  description       = "Egress Rule"
}