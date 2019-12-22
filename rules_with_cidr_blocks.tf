// Security Group Rules Resource for Module
module "cidr_blocks_0" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 0 ? var.ingress_cidr_blocks[0] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 0 ? var.egress_cidr_blocks[0] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_1" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 1 ? var.ingress_cidr_blocks[1] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 1 ? var.egress_cidr_blocks[1] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_2" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 2 ? var.ingress_cidr_blocks[2] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 2 ? var.egress_cidr_blocks[2] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_3" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 3 ? var.ingress_cidr_blocks[3] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 3 ? var.egress_cidr_blocks[3] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_4" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 4 ? var.ingress_cidr_blocks[4] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 4 ? var.egress_cidr_blocks[4] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_5" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 5 ? var.ingress_cidr_blocks[5] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 5 ? var.egress_cidr_blocks[5] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_6" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 6 ? var.ingress_cidr_blocks[6] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 6 ? var.egress_cidr_blocks[6] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_7" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 7 ? var.ingress_cidr_blocks[7] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 7 ? var.egress_cidr_blocks[7] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_8" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 8 ? var.ingress_cidr_blocks[8] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 8 ? var.egress_cidr_blocks[8] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_9" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 9 ? var.ingress_cidr_blocks[9] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 9 ? var.egress_cidr_blocks[9] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}

module "cidr_blocks_10" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 10 ? var.ingress_cidr_blocks[10] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 10 ? var.egress_cidr_blocks[10] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_11" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 11 ? var.ingress_cidr_blocks[11] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 11 ? var.egress_cidr_blocks[11] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_12" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 12 ? var.ingress_cidr_blocks[12] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 12 ? var.egress_cidr_blocks[12] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_13" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 13 ? var.ingress_cidr_blocks[13] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 13 ? var.egress_cidr_blocks[13] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_14" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 14 ? var.ingress_cidr_blocks[14] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 14 ? var.egress_cidr_blocks[14] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_15" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 15 ? var.ingress_cidr_blocks[15] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 15 ? var.egress_cidr_blocks[15] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_16" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 16 ? var.ingress_cidr_blocks[16] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 16 ? var.egress_cidr_blocks[16] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_17" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 17 ? var.ingress_cidr_blocks[17] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 17 ? var.egress_cidr_blocks[17] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_18" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 18 ? var.ingress_cidr_blocks[18] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 18 ? var.egress_cidr_blocks[18] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}
module "cidr_blocks_19" {
  source   = "./modules/rules_with_cidr_blocks"
  create   = local.create_rules
  group_id = local.this_sg_id
  rules    = var.rules

  ingress_cidr_block              = length(var.ingress_cidr_blocks) > 19 ? var.ingress_cidr_blocks[19] : ""
  ingress_rules                   = var.ingress_rules
  ingress_with_cidr_blocks        = var.ingress_with_cidr_blocks
  ingress_with_ports              = var.ingress_with_ports
  protocol_for_ingress_with_ports = var.protocol_for_ingress_with_ports
  priority_for_ingress_with_ports = var.priority_for_ingress_with_ports
  default_ingress_priority        = var.default_ingress_priority
  priority_for_ingress_rules      = var.priority_for_ingress_rules

  egress_cidr_block              = length(var.egress_cidr_blocks) > 19 ? var.egress_cidr_blocks[19] : ""
  egress_rules                   = var.egress_rules
  egress_with_cidr_blocks        = var.egress_with_cidr_blocks
  egress_with_ports              = var.egress_with_ports
  protocol_for_egress_with_ports = var.protocol_for_egress_with_ports
  priority_for_egress_with_ports = var.priority_for_egress_with_ports
  default_egress_priority        = var.default_ingress_priority
  priority_for_egress_rules      = var.priority_for_egress_rules
}