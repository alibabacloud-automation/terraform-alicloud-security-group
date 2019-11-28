module "sg" {
  source = "../../"

  create            = var.create
  group_name        = var.group_name
  group_description = var.group_description
  vpc_id            = var.vpc_id
  priority          = var.priority

  ##########
  # Ingress
  ##########
  # Rules by names - open for default CIDR
  ingress_rules = sort(compact(distinct(concat(var.auto_ingress_rules, var.ingress_rules, [""]))))

  # Open to IPv4 cidr blocks
  ingress_with_cidr_block = var.ingress_with_cidr_block

  # Open for security group id
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id

  # Default ingress CIDR blocks
  ingress_cidr_block = var.ingress_cidr_block


  #########
  # Egress
  #########
  # Rules by names - open for default CIDR
  egress_rules = sort(compact(distinct(concat(var.auto_egress_rules, var.egress_rules, [""]))))

  # Open for self

  # Open to IPv4 cidr blocks
  egress_with_cidr_block = var.egress_with_cidr_block

  # Open for security group id
  egress_with_source_security_group_id = var.egress_with_source_security_group_id

  # Default egress CIDR blocks
  egress_cidr_block = var.egress_cidr_block

}
