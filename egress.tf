// Security Group Rules Resource for Module
module "egress_0" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 0 ? var.egress_cidr_blocks[0] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_1" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 1 ? var.egress_cidr_blocks[1] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_2" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 2 ? var.egress_cidr_blocks[2] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_3" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 3 ? var.egress_cidr_blocks[3] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_4" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 4 ? var.egress_cidr_blocks[4] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_5" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 5 ? var.egress_cidr_blocks[5] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_6" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 6 ? var.egress_cidr_blocks[6] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_7" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 7 ? var.egress_cidr_blocks[7] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_8" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 8 ? var.egress_cidr_blocks[8] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_9" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 9 ? var.egress_cidr_blocks[9] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}

module "egress_10" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 10 ? var.egress_cidr_blocks[10] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_11" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 11 ? var.egress_cidr_blocks[11] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_12" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 12 ? var.egress_cidr_blocks[12] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_13" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 13 ? var.egress_cidr_blocks[13] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_14" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 14 ? var.egress_cidr_blocks[14] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_15" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 15 ? var.egress_cidr_blocks[15] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_16" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 16 ? var.egress_cidr_blocks[16] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_17" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 17 ? var.egress_cidr_blocks[17] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_18" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 18 ? var.egress_cidr_blocks[18] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_19" {
  source                               = "./modules/egress"
  egress_cidr_block                    = length(var.egress_cidr_blocks) > 19 ? var.egress_cidr_blocks[19] : ""
  group_id                             = local.group_id
  rules                                = var.rules
  egress_rules                         = var.egress_rules
  egress_with_cidr_blocks              = var.egress_with_cidr_blocks
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_with_ports                    = var.egress_with_ports
  protocol_for_egress_with_ports       = var.protocol_for_egress_with_ports
  default_priority                     = var.default_egress_priority
  priority_for_egress_rules            = var.priority_for_egress_rules
}
module "egress_with_cidr_block" {
  source                 = "./modules/egress"
  group_id               = local.group_id
  rules                  = var.rules
  egress_with_cidr_block = var.egress_with_cidr_block
  default_priority       = var.default_egress_priority
}