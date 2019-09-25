provider "alicloud" {
  version              = ">=1.56.0"
  region               = var.region != "" ? var.region : null
  configuration_source = "terraform-alicloud-modules/security-group"
}

// If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count      = var.vpc_id == "" ? 1 : 0
  cidr_block = var.vpc_cidr
  name       = var.vpc_name == "" ? var.this_module_name : var.vpc_name
}

// Security Group Resource for Module
resource "alicloud_security_group" "group" {
  count       = var.group_id == "" ? 1 : 0
  name        = var.group_name == "" ? var.this_module_name : var.group_name
  vpc_id      = var.vpc_id == "" ? alicloud_vpc.vpc.0.id : var.vpc_id
  description = var.group_description
}

// Security Group Resource for Module
resource "alicloud_security_group_rule" "rules_cidr" {
  count = length(var.cidr_ips) > 0 ? length(var.ip_protocols) : 0

  type              = var.rule_directions[count.index]
  ip_protocol       = var.ip_protocols[count.index]
  nic_type          = "intranet"
  policy            = var.policies[count.index]
  port_range        = var.port_ranges[count.index]
  priority          = var.priorities[count.index]
  security_group_id = var.group_id == "" ? alicloud_security_group.group[0].id : var.group_id
  cidr_ip           = var.cidr_ips[count.index]
}

resource "alicloud_security_group_rule" "rules_group" {
  count = length(var.source_security_group_ids) > 0 ? length(var.ip_protocols) : 0

  type                       = var.rule_directions[count.index]
  ip_protocol                = var.ip_protocols[count.index]
  nic_type                   = "intranet"
  policy                     = var.policies[count.index]
  port_range                 = var.port_ranges[count.index]
  priority                   = var.priorities[count.index]
  security_group_id          = var.group_id == "" ? alicloud_security_group.group[0].id : var.group_id
  source_security_group_id   = var.source_security_group_ids[count.index]
  source_group_owner_account = var.source_group_owner_accounts[count.index]
}

