provider "alicloud" {
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

###################################
# Ingress - List of rules (simple)
###################################
locals {
  ingress_rules = flatten(
    [
      for _, obj in var.ingress_rules : [
        for _, cidr in var.ingress_cidr_blocks : {
          cidr_block = cidr
          rule       = obj
        }
      ]
    ]
  )
}
resource "alicloud_security_group_rule" "ingress_rules" {
  count             = local.create_rules ? length(local.ingress_rules) : 0
  security_group_id = local.this_sg_id

  type        = "ingress"
  nic_type    = "intranet"
  ip_protocol = var.rules[lookup(local.ingress_rules[count.index], "rule", )][2]
  port_range  = "${var.rules[lookup(local.ingress_rules[count.index], "rule", )][0]}/${var.rules[lookup(local.ingress_rules[count.index], "rule", )][1]}"
  cidr_ip     = lookup(local.ingress_rules[count.index], "cidr_block", )
  priority    = var.priority_for_ingress_rules > 0 ? var.priority_for_ingress_rules : var.default_ingress_priority
  description = var.rules[lookup(local.ingress_rules[count.index], "rule", )][3]
}
##########################
# (Deprecated From v2.1.0) Ingress - Maps of rules and each item with cidr_block.
##########################
resource "alicloud_security_group_rule" "ingress_with_cidr_block" {
  count             = local.create_rules ? length(var.ingress_with_cidr_block) : 0
  security_group_id = local.this_sg_id

  type        = "ingress"
  ip_protocol = lookup(var.ingress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type    = "intranet"
  port_range  = "${lookup(var.ingress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.ingress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.ingress_with_cidr_block[count.index], "rule", "_")][1], )}"
  cidr_ip     = lookup(var.ingress_with_cidr_block[count.index], "cidr_block", split(",", lookup(var.ingress_with_cidr_block[count.index], "cidr_blocks", ""))[0])
  priority    = lookup(var.ingress_with_cidr_block[count.index], "priority", var.default_ingress_priority)
  description = lookup(var.ingress_with_cidr_block[count.index], "description", "Ingress Rule")
}

##########################
# (Available In v2.1.0+)Ingress - Maps of rules and each item with cidr_blocks or ingress_cidr_blocks
##########################
locals {
  ingress_with_cidr_blocks = flatten(
    [
      for _, obj in var.ingress_with_cidr_blocks : [
        for _, cidr in split(",", lookup(obj, "cidr_blocks", join(",", var.ingress_cidr_blocks))) : {
          cidr_block  = cidr
          priority    = lookup(obj, "priority", var.default_ingress_priority)
          from_port   = lookup(obj, "from_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][0])
          to_port     = lookup(obj, "to_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][1])
          protocol    = lookup(obj, "protocol", lookup(obj, "rule", null) == null ? "" : var.rules[lookup(obj, "rule", "_")][2])
          description = lookup(obj, "description", lookup(obj, "rule", null) == null ? format("Ingress Rule With Cidr Block %s", cidr) : var.rules[lookup(obj, "rule", "_")][3])
        }
      ]
    ]
  )
}
resource "alicloud_security_group_rule" "ingress_with_cidr_blocks" {
  count             = local.create_rules ? length(local.ingress_with_cidr_blocks) : 0
  security_group_id = local.this_sg_id

  type        = "ingress"
  ip_protocol = lookup(local.ingress_with_cidr_blocks[count.index], "protocol", )
  nic_type    = "intranet"
  port_range  = "${lookup(local.ingress_with_cidr_blocks[count.index], "from_port", )}/${lookup(local.ingress_with_cidr_blocks[count.index], "to_port", )}"
  cidr_ip     = lookup(local.ingress_with_cidr_blocks[count.index], "cidr_block", )
  priority    = lookup(local.ingress_with_cidr_blocks[count.index], "priority", )
  description = lookup(local.ingress_with_cidr_blocks[count.index], "description", )
}

##########################
# Ingress - Using a list of ports
##########################
locals {
  // For compatibility: ingress_with_ports, priority_for_ingress_with_ports and protocol_for_ingress_with_ports
  ingress_ports            = length(var.ingress_ports) > 0 ? var.ingress_ports : var.ingress_with_ports
  default_ingress_priority = var.priority_for_ingress_with_ports > 0 ? var.priority_for_ingress_with_ports : var.default_ingress_priority

  ingress_with_cidr_blocks_and_ports = flatten(
    [
      for _, obj in var.ingress_with_cidr_blocks_and_ports : [
        for _, cidr in split(",", lookup(obj, "cidr_blocks", join(",", var.ingress_cidr_blocks))) : [
          for _, port in split(",", lookup(obj, "ports", join(",", local.ingress_ports))) : {
            cidr_block  = cidr
            priority    = lookup(obj, "priority", local.default_ingress_priority)
            from_port   = port
            to_port     = port
            protocol    = lookup(obj, "protocol", var.protocol_for_ingress_with_ports)
            description = lookup(obj, "description", format("Ingress Rule With Cidr Block %s and Port %s", cidr, port))
          }
        ]
      ]
    ]
  )
}
resource "alicloud_security_group_rule" "ingress_with_cidr_blocks_and_ports" {
  count             = local.create_rules ? length(local.ingress_with_cidr_blocks_and_ports) : 0
  security_group_id = local.this_sg_id

  type        = "ingress"
  ip_protocol = lookup(local.ingress_with_cidr_blocks_and_ports[count.index], "protocol", )
  nic_type    = "intranet"
  port_range  = "${lookup(local.ingress_with_cidr_blocks_and_ports[count.index], "from_port", )}/${lookup(local.ingress_with_cidr_blocks_and_ports[count.index], "to_port", )}"
  cidr_ip     = lookup(local.ingress_with_cidr_blocks_and_ports[count.index], "cidr_block", )
  priority    = lookup(local.ingress_with_cidr_blocks_and_ports[count.index], "priority", )
  description = lookup(local.ingress_with_cidr_blocks_and_ports[count.index], "description", )
}

##########################
# Ingress - Maps of rules and each item with source_security_group_id
##########################
locals {
  ingress_with_source_security_group_id = flatten(
    [
      for _, obj in var.ingress_with_source_security_group_id : {
        source_security_group_id = lookup(obj, "source_security_group_id", "")
        priority                 = lookup(obj, "priority", var.default_egress_priority)
        from_port                = lookup(obj, "from_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][0])
        to_port                  = lookup(obj, "to_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][1])
        protocol                 = lookup(obj, "protocol", lookup(obj, "rule", null) == null ? "" : var.rules[lookup(obj, "rule", "_")][2])
        description              = lookup(obj, "description", lookup(obj, "rule", null) == null ? format("Ingress Rule With Source Security Group %s", lookup(obj, "source_security_group_id", "")) : var.rules[lookup(obj, "rule", "_")][3])
      }
    ]
  )
}
resource "alicloud_security_group_rule" "ingress_with_source_security_group_id" {
  count             = local.create_rules ? length(local.ingress_with_source_security_group_id) : 0
  security_group_id = local.this_sg_id

  type                     = "ingress"
  ip_protocol              = lookup(local.ingress_with_source_security_group_id[count.index], "protocol", )
  nic_type                 = "intranet"
  port_range               = "${lookup(local.ingress_with_source_security_group_id[count.index], "from_port", )}/${lookup(local.ingress_with_source_security_group_id[count.index], "to_port", )}"
  source_security_group_id = lookup(local.ingress_with_source_security_group_id[count.index], "source_security_group_id", )
  priority                 = lookup(local.ingress_with_source_security_group_id[count.index], "priority", )
  description              = lookup(local.ingress_with_source_security_group_id[count.index], "description", )
}

###################################
# Egress - List of rules (simple)
###################################
locals {
  egress_rules = flatten(
    [
      for _, obj in var.egress_rules : [
        for _, cidr in var.egress_cidr_blocks : {
          cidr_block = cidr
          rule       = obj
        }
      ]
    ]
  )
}
resource "alicloud_security_group_rule" "egress_rules" {
  count             = local.create_rules ? length(local.egress_rules) : 0
  security_group_id = local.this_sg_id

  type        = "egress"
  nic_type    = "intranet"
  ip_protocol = var.rules[lookup(local.egress_rules[count.index], "rule", )][2]
  port_range  = "${var.rules[lookup(local.egress_rules[count.index], "rule", )][0]}/${var.rules[lookup(local.egress_rules[count.index], "rule", )][1]}"
  cidr_ip     = lookup(local.egress_rules[count.index], "cidr_block", )
  priority    = var.priority_for_egress_rules > 0 ? var.priority_for_egress_rules : var.default_egress_priority
  description = var.rules[lookup(local.egress_rules[count.index], "rule", )][3]
}
##########################
# (Deprecated From v2.1.0) Egress - Maps of rules and each item with cidr_block
##########################
resource "alicloud_security_group_rule" "egress_with_cidr_block" {
  count             = local.create_rules ? length(var.egress_with_cidr_block) : 0
  security_group_id = local.this_sg_id

  type        = "egress"
  ip_protocol = lookup(var.egress_with_cidr_block[count.index], "protocol", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][2], )
  nic_type    = "intranet"
  port_range  = "${lookup(var.egress_with_cidr_block[count.index], "from_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][0], )}/${lookup(var.egress_with_cidr_block[count.index], "to_port", var.rules[lookup(var.egress_with_cidr_block[count.index], "rule", "_")][1], )}"
  cidr_ip     = lookup(var.egress_with_cidr_block[count.index], "cidr_block", split(",", lookup(var.egress_with_cidr_block[count.index], "cidr_blocks", ""))[0])
  priority    = lookup(var.egress_with_cidr_block[count.index], "priority", var.default_egress_priority)
  description = lookup(var.egress_with_cidr_block[count.index], "description", "Egress Rule")
}

##########################
# (Available In v2.1.0+) Egress - Maps of rules and each item with cidr_blocks or egress_cidr_blocks
##########################
locals {
  egress_with_cidr_blocks = flatten(
    [
      for _, obj in var.egress_with_cidr_blocks : [
        for _, cidr in split(",", lookup(obj, "cidr_blocks", join(",", var.egress_cidr_blocks))) : {
          cidr_block  = cidr
          priority    = lookup(obj, "priority", var.default_egress_priority)
          from_port   = lookup(obj, "from_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][0])
          to_port     = lookup(obj, "to_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][1])
          protocol    = lookup(obj, "protocol", lookup(obj, "rule", null) == null ? "" : var.rules[lookup(obj, "rule", "_")][2])
          description = lookup(obj, "description", lookup(obj, "rule", null) == null ? format("Egress Rule With Cidr Block %s", cidr) : var.rules[lookup(obj, "rule", "_")][3])
        }
      ]
    ]
  )
}
resource "alicloud_security_group_rule" "egress_with_cidr_blocks" {
  count             = local.create_rules ? length(local.egress_with_cidr_blocks) : 0
  security_group_id = local.this_sg_id

  type        = "egress"
  ip_protocol = lookup(local.egress_with_cidr_blocks[count.index], "protocol", )
  nic_type    = "intranet"
  port_range  = "${lookup(local.egress_with_cidr_blocks[count.index], "from_port", )}/${lookup(local.egress_with_cidr_blocks[count.index], "to_port", )}"
  cidr_ip     = lookup(local.egress_with_cidr_blocks[count.index], "cidr_block", )
  priority    = lookup(local.egress_with_cidr_blocks[count.index], "priority", )
  description = lookup(local.egress_with_cidr_blocks[count.index], "description", )
}

##########################
# Egress - Using a list of ports
##########################
locals {
  // For compatibility: ingress_with_ports, priority_for_ingress_with_ports and protocol_for_ingress_with_ports
  egress_ports            = length(var.egress_ports) > 0 ? var.egress_ports : var.egress_with_ports
  default_egress_priority = var.priority_for_egress_with_ports > 0 ? var.priority_for_egress_with_ports : var.default_egress_priority

  egress_with_cidr_blocks_and_ports = flatten(
    [
      for _, obj in var.egress_with_cidr_blocks_and_ports : [
        for _, cidr in split(",", lookup(obj, "cidr_blocks", join(",", var.egress_cidr_blocks))) : [
          for _, port in split(",", lookup(obj, "ports", join(",", local.egress_ports))) : {
            cidr_block  = cidr
            priority    = lookup(obj, "priority", local.default_egress_priority)
            from_port   = port
            to_port     = port
            protocol    = lookup(obj, "protocol", var.protocol_for_egress_with_ports)
            description = lookup(obj, "description", format("Egress Rule With Cidr Block %s and Port %s", cidr, port))
          }
        ]
      ]
    ]
  )
}
resource "alicloud_security_group_rule" "egress_with_cidr_blocks_and_ports" {
  count             = local.create_rules ? length(local.egress_with_cidr_blocks_and_ports) : 0
  security_group_id = local.this_sg_id

  type        = "egress"
  ip_protocol = lookup(local.egress_with_cidr_blocks_and_ports[count.index], "protocol", )
  nic_type    = "intranet"
  port_range  = "${lookup(local.egress_with_cidr_blocks_and_ports[count.index], "from_port", )}/${lookup(local.egress_with_cidr_blocks_and_ports[count.index], "to_port", )}"
  cidr_ip     = lookup(local.egress_with_cidr_blocks_and_ports[count.index], "cidr_block", )
  priority    = lookup(local.egress_with_cidr_blocks_and_ports[count.index], "priority", )
  description = lookup(local.egress_with_cidr_blocks_and_ports[count.index], "description", )
}

##########################
# Egress - Maps of rules and each item with source_security_group_id
##########################
locals {
  egress_with_source_security_group_id = flatten(
    [
      for _, obj in var.egress_with_source_security_group_id : {
        source_security_group_id = lookup(obj, "source_security_group_id", "")
        priority                 = lookup(obj, "priority", var.default_egress_priority)
        from_port                = lookup(obj, "from_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][0])
        to_port                  = lookup(obj, "to_port", lookup(obj, "rule", null) == null ? 0 : var.rules[lookup(obj, "rule", "_")][1])
        protocol                 = lookup(obj, "protocol", lookup(obj, "rule", null) == null ? "" : var.rules[lookup(obj, "rule", "_")][2])
        description              = lookup(obj, "description", lookup(obj, "rule", null) == null ? format("Egress Rule With Source Security Group %s", lookup(obj, "source_security_group_id", "")) : var.rules[lookup(obj, "rule", "_")][3])
      }
    ]
  )
}
resource "alicloud_security_group_rule" "egress_with_source_security_group_id" {
  count             = local.create_rules ? length(local.egress_with_source_security_group_id) : 0
  security_group_id = local.this_sg_id

  type                     = "egress"
  ip_protocol              = lookup(local.egress_with_source_security_group_id[count.index], "protocol", )
  nic_type                 = "intranet"
  port_range               = "${lookup(local.egress_with_source_security_group_id[count.index], "from_port", )}/${lookup(local.egress_with_source_security_group_id[count.index], "to_port", )}"
  source_security_group_id = local.egress_with_source_security_group_id[count.index]["source_security_group_id"]
  priority                 = lookup(local.egress_with_source_security_group_id[count.index], "priority", )
  description              = lookup(local.egress_with_source_security_group_id[count.index], "description", )
}