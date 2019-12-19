// Security Group Rules Resource for Module
module "ingress_0" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 0 ? var.ingress_cidr_blocks[0] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_1" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 1 ? var.ingress_cidr_blocks[1] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_2" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 2 ? var.ingress_cidr_blocks[2] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_3" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 3 ? var.ingress_cidr_blocks[3] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_4" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 4 ? var.ingress_cidr_blocks[4] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_5" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 5 ? var.ingress_cidr_blocks[5] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_6" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 6 ? var.ingress_cidr_blocks[6] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_7" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 7 ? var.ingress_cidr_blocks[7] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_8" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 8 ? var.ingress_cidr_blocks[8] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_9" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 9 ? var.ingress_cidr_blocks[9] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}

module "ingress_10" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 10 ? var.ingress_cidr_blocks[10] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_11" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 11 ? var.ingress_cidr_blocks[11] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_12" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 12 ? var.ingress_cidr_blocks[12] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_13" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 13 ? var.ingress_cidr_blocks[13] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_14" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 14 ? var.ingress_cidr_blocks[14] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_15" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 15 ? var.ingress_cidr_blocks[15] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_16" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 16 ? var.ingress_cidr_blocks[16] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_17" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 17 ? var.ingress_cidr_blocks[17] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_18" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 18 ? var.ingress_cidr_blocks[18] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_19" {
  source                                = "./modules/ingress"
  ingress_cidr_block                    = length(var.ingress_cidr_blocks) > 19 ? var.ingress_cidr_blocks[19] : ""
  group_id                              = local.group_id
  rules                                 = var.rules
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  ingress_with_ports                    = var.ingress_with_ports
  protocol_for_ingress_with_ports       = var.protocol_for_ingress_with_ports
  default_priority                      = var.default_ingress_priority
  priority_for_ingress_rules            = var.priority_for_ingress_rules
}
module "ingress_with_cidr_block" {
  source                  = "./modules/ingress"
  group_id                = local.group_id
  rules                   = var.rules
  ingress_with_cidr_block = var.ingress_with_cidr_block
  default_priority        = var.default_ingress_priority
}