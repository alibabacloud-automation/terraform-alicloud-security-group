// Security Group Resource for Module
resource "alicloud_security_group_rule" "egress_rules" {
  count             = var.egress_cidr_block != "" ? length(var.egress_rules) : 0
  type              = "egress"
  ip_protocol       = var.rules[var.egress_rules[count.index]][2]
  nic_type          = "intranet"
  port_range        = "${var.rules[var.egress_rules[count.index]][0]}/${var.rules[var.egress_rules[count.index]][1]}"
  security_group_id = var.group_id
  cidr_ip           = var.egress_cidr_block
  priority          = var.priority_for_egress_rules > 0 ? var.priority_for_egress_rules : var.default_priority
  description       = var.rules[var.egress_rules[count.index]][3]
}

resource "alicloud_security_group_rule" "egress_with_cidr_block" {
  count             = length(var.egress_with_cidr_block)
  type              = "egress"
  ip_protocol       = lookup(var.egress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.egress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.egress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id
  cidr_ip           = var.egress_with_cidr_block[count.index]["cidr_block"]
  priority          = lookup(var.egress_with_cidr_block[count.index], "priority", var.default_priority)
  description       = lookup(var.egress_with_cidr_block[count.index], "description", "egress Rule")
}

resource "alicloud_security_group_rule" "egress_with_cidr_blocks" {
  count             = var.egress_cidr_block != "" ? length(var.egress_with_cidr_blocks) : 0
  type              = "egress"
  ip_protocol       = lookup(var.egress_with_cidr_blocks[count.index], "protocol", var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.egress_with_cidr_blocks[count.index], "from_port", var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][0], )}/${lookup(var.egress_with_cidr_blocks[count.index], "to_port", var.rules[lookup(var.egress_with_cidr_blocks[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id
  cidr_ip           = var.egress_cidr_block
  priority          = lookup(var.egress_with_cidr_blocks[count.index], "priority", var.default_priority)
  description       = lookup(var.egress_with_cidr_blocks[count.index], "description", "egress Rule")
}

resource "alicloud_security_group_rule" "egress_with_source_security_group_id" {
  count                    = length(var.egress_with_source_security_group_id)
  type                     = "egress"
  ip_protocol              = lookup(var.egress_with_source_security_group_id[count.index], "protocol", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][2], )
  nic_type                 = "intranet"
  port_range               = "${lookup(var.egress_with_source_security_group_id[count.index], "from_port", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][0], )}/${lookup(var.egress_with_source_security_group_id[count.index], "to_port", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][1], )}"
  security_group_id        = var.group_id
  source_security_group_id = var.egress_with_source_security_group_id[count.index]["source_security_group_id"]
  priority                 = lookup(var.egress_with_source_security_group_id[count.index], "priority", var.default_priority)
  description              = lookup(var.egress_with_source_security_group_id[count.index], "description", "egress Rule")
}

resource "alicloud_security_group_rule" "egress_with_ports" {
  count             = var.egress_cidr_block != "" ? length(var.egress_with_ports) : 0
  type              = "egress"
  ip_protocol       = var.protocol_for_egress_with_ports
  nic_type          = "intranet"
  port_range        = "${var.egress_with_ports[count.index]}/${var.egress_with_ports[count.index]}"
  security_group_id = var.group_id
  cidr_ip           = var.egress_cidr_block
  priority          = var.default_priority
  description       = "egress Rule"
}