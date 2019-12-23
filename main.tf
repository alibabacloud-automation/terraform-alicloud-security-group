provider "alicloud" {
  version                 = ">=1.56.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/security-group"
}

// Create a new Security Group Resource for Module
resource "alicloud_security_group" "this" {
  count       = var.existing_group_id != "" ? 0 : var.create ? 1 : 0
  name        = local.group_name
  vpc_id      = var.vpc_id
  description = local.description
  tags        = var.tags
}

##########################
# Ingress - Maps of rules and each item with cidr_block
##########################
resource "alicloud_security_group_rule" "ingress_with_cidr_block" {
  count             = local.create_rules ? length(var.ingress_with_cidr_block) : 0
  type              = "ingress"
  ip_protocol       = lookup(var.ingress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.ingress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.ingress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][1], )}"
  security_group_id = local.this_sg_id
  cidr_ip           = lookup(var.ingress_with_cidr_block[count.index], "cidr_block", split(",", lookup(var.ingress_with_cidr_block[count.index], "cidr_blocks", ""))[0])
  priority          = lookup(var.ingress_with_cidr_block[count.index], "priority", var.default_ingress_priority)
  description       = lookup(var.ingress_with_cidr_block[count.index], "description", "Ingress Rule")
}

##########################
# Ingress - Maps of rules and each item with source_security_group_id
##########################
resource "alicloud_security_group_rule" "ingress_with_source_security_group_id" {
  count                    = local.create_rules ? length(var.ingress_with_source_security_group_id) : 0
  type                     = "ingress"
  ip_protocol              = lookup(var.ingress_with_source_security_group_id[count.index], "protocol", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][2], )
  nic_type                 = "intranet"
  port_range               = "${lookup(var.ingress_with_source_security_group_id[count.index], "from_port", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][0], )}/${lookup(var.ingress_with_source_security_group_id[count.index], "to_port", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][1], )}"
  security_group_id        = local.this_sg_id
  source_security_group_id = var.ingress_with_source_security_group_id[count.index]["source_security_group_id"]
  priority                 = lookup(var.ingress_with_source_security_group_id[count.index], "priority", var.default_ingress_priority)
  description              = lookup(var.ingress_with_source_security_group_id[count.index], "description", "Ingress Rule")
}

##########################
# Egress - Maps of rules and each item with cidr_block
##########################
resource "alicloud_security_group_rule" "egress_with_cidr_block" {
  count             = local.create_rules ? length(var.egress_with_cidr_block) : 0
  type              = "egress"
  ip_protocol       = lookup(var.egress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.egress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.egress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][1], )}"
  security_group_id = local.this_sg_id
  cidr_ip           = lookup(var.egress_with_cidr_block[count.index], "cidr_block", split(",", lookup(var.egress_with_cidr_block[count.index], "cidr_blocks", ""))[0])
  priority          = lookup(var.egress_with_cidr_block[count.index], "priority", var.default_egress_priority)
  description       = lookup(var.egress_with_cidr_block[count.index], "description", "Egress Rule")
}
##########################
# Egress - Maps of rules and each item with source_security_group_id
##########################
resource "alicloud_security_group_rule" "egress_with_source_security_group_id" {
  count                    = local.create_rules ? length(var.egress_with_source_security_group_id) : 0
  type                     = "egress"
  ip_protocol              = lookup(var.egress_with_source_security_group_id[count.index], "protocol", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][2], )
  nic_type                 = "intranet"
  port_range               = "${lookup(var.egress_with_source_security_group_id[count.index], "from_port", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][0], )}/${lookup(var.egress_with_source_security_group_id[count.index], "to_port", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][1], )}"
  security_group_id        = local.this_sg_id
  source_security_group_id = var.egress_with_source_security_group_id[count.index]["source_security_group_id"]
  priority                 = lookup(var.egress_with_source_security_group_id[count.index], "priority", var.default_egress_priority)
  description              = lookup(var.egress_with_source_security_group_id[count.index], "description", "Egress Rule")
}