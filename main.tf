provider "alicloud" {
  version                 = ">=1.56.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/security-group"
}

// If there is not specifying vpc_id, the module will launch a new vpc

// Security Group Resource for Module
resource "alicloud_security_group" "this" {
  count       = var.group_id == "" ? 1 : 0
  name        = var.group_name == "" ? var.this_module_name : var.group_name
  vpc_id      = var.vpc_id == "" ? alicloud_vpc.vpc.0.id : var.vpc_id
  description = var.group_description
}

// Security Group Resource for Module

resource "alicloud_security_group_rule" "ingress_rules_cidr" {
  count             = var.create ? length(var.ingress_with_cidr_block) : 0
  type              = "ingress"
  ip_protocol       = lookup(var.ingress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.ingress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.ingress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id == "" ? alicloud_security_group.this[0].id : var.group_id
  cidr_ip           = lookup(var.ingress_with_cidr_block[count.index], "cidr_block", var.ingress_cidr_block)
  priority          = var.priority
  description       = "An Security group rule came from terraform-alicloud-modules/security-group"
}

resource "alicloud_security_group_rule" "ingress_rules_group" {
  count                    = var.create ? length(var.ingress_with_source_security_group_id) : 0
  type                     = "ingress"
  ip_protocol              = lookup(var.ingress_with_source_security_group_id[count.index], "protocol", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][2], )
  nic_type                 = "intranet"
  port_range               = "${lookup(var.ingress_with_source_security_group_id[count.index], "from_port", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][0], )}/${lookup(var.ingress_with_source_security_group_id[count.index], "to_port", var.rules[lookup(var.ingress_with_source_security_group_id[count.index], "rule", "_", )][1], )}"
  security_group_id        = var.group_id == "" ? alicloud_security_group.this[0].id : var.group_id
  source_security_group_id = var.ingress_with_source_security_group_id[count.index]["source_security_group_id"]
  priority                 = var.priority
  description              = "An Security group rule came from terraform-alicloud-modules/security-group"
}

resource "alicloud_security_group_rule" "egress_rules_cidr" {
  count             = var.create ? length(var.egress_with_cidr_block) : 0
  type              = "egress"
  ip_protocol       = lookup(var.egress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type          = "intranet"
  port_range        = "${lookup(var.egress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.egress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][1], )}"
  security_group_id = var.group_id == "" ? alicloud_security_group.this[0].id : var.group_id
  cidr_ip           = lookup(var.egress_with_cidr_block[count.index], "cidr_block", var.egress_cidr_block)
  priority          = var.priority
  description       = "An Security group rule came from terraform-alicloud-modules/security-group"
}

resource "alicloud_security_group_rule" "egress_rules_group" {
  count                    = var.create ? length(var.egress_with_source_security_group_id) : 0
  type                     = "egress"
  ip_protocol              = lookup(var.egress_with_source_security_group_id[count.index], "protocol", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][2], )
  nic_type                 = "intranet"
  port_range               = "${lookup(var.egress_with_source_security_group_id[count.index], "from_port", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][0], )}/${lookup(var.egress_with_source_security_group_id[count.index], "to_port", var.rules[lookup(var.egress_with_source_security_group_id[count.index], "rule", "_", )][1], )}"
  security_group_id        = var.group_id == "" ? alicloud_security_group.this[0].id : var.group_id
  source_security_group_id = var.egress_with_source_security_group_id[count.index]["source_security_group_id"]
  priority                 = var.priority
  description              = "An Security group rule came from terraform-alicloud-modules/security-group"
}