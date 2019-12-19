// Security Group Resource for Module
resource "alicloud_security_group_rule" "ingress_rules" {
  count             = var.group_id != "" && var.ingress_cidr_block != "" ? length(var.ingress_rules) : 0
  type              = "ingress"
  ip_protocol       = var.rules[var.ingress_rules[count.index]][2]
  nic_type          = "intranet"
  port_range        = "${var.rules[var.ingress_rules[count.index]][0]}/${var.rules[var.ingress_rules[count.index]][1]}"
  security_group_id = var.group_id
  cidr_ip           = var.ingress_cidr_block
  priority          = var.priority_for_ingress_rules > 0 ? var.priority_for_ingress_rules : var.default_priority
  description       = var.rules[var.ingress_rules[count.index]][3]
}

resource "alicloud_security_group_rule" "ingress_with_cidr_block" {
  count             = var.group_id != "" ? length(var.ingress_with_cidr_block) : 0
  type              = "ingress"
  ip_protocol       = lookup(var.ingress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.ingress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.ingress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id
  cidr_ip           = var.ingress_with_cidr_block[count.index]["cidr_block"]
  priority          = lookup(var.ingress_with_cidr_block[count.index], "priority", var.default_priority)
  description       = lookup(var.ingress_with_cidr_block[count.index], "description", "Ingress Rule")
}

resource "alicloud_security_group_rule" "ingress_with_cidr_blocks" {
  count             = var.group_id != "" && var.ingress_cidr_block != "" ? length(var.ingress_with_cidr_blocks) : 0
  type              = "ingress"
  ip_protocol       = lookup(var.ingress_with_cidr_blocks[count.index], "protocol", var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.ingress_with_cidr_blocks[count.index], "from_port", var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][0], )}/${lookup(var.ingress_with_cidr_blocks[count.index], "to_port", var.rules[lookup(var.ingress_with_cidr_blocks[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id
  cidr_ip           = var.ingress_cidr_block
  priority          = lookup(var.ingress_with_cidr_blocks[count.index], "priority", var.default_priority)
  description       = lookup(var.ingress_with_cidr_blocks[count.index], "description", "Ingress Rule")
}

resource "alicloud_security_group_rule" "ingress_with_source_security_group_id" {
  count                    = var.group_id != "" ? length(var.ingress_with_source_security_group_id) : 0
  type                     = "ingress"
  ip_protocol              = lookup(var.ingress_with_source_security_group_id[count.index], "protocol", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][2], )
  nic_type                 = "intranet"
  port_range               = "${lookup(var.ingress_with_source_security_group_id[count.index], "from_port", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][0], )}/${lookup(var.ingress_with_source_security_group_id[count.index], "to_port", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][1], )}"
  security_group_id        = var.group_id
  source_security_group_id = var.ingress_with_source_security_group_id[count.index]["source_security_group_id"]
  priority                 = lookup(var.ingress_with_source_security_group_id[count.index], "priority", var.default_priority)
  description              = lookup(var.ingress_with_source_security_group_id[count.index], "description", "Ingress Rule")
}

resource "alicloud_security_group_rule" "ingress_with_ports" {
  count             = var.group_id != "" && var.ingress_cidr_block != "" ? length(var.ingress_with_ports) : 0
  type              = "ingress"
  ip_protocol       = var.protocol_for_ingress_with_ports
  nic_type          = "intranet"
  port_range        = "${var.ingress_with_ports[count.index]}/${var.ingress_with_ports[count.index]}"
  security_group_id = var.group_id
  cidr_ip           = var.ingress_cidr_block
  priority          = var.default_priority
  description       = "Ingress Rule"
}