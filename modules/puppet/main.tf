module "sg" {
  source = "../../"

  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = var.shared_credentials_file
  skip_region_validation  = var.skip_region_validation
  create                  = var.create
  create_vpc              = var.create_vpc
  default_protocol        = var.default_protocol
  this_module_name        = var.this_module_name
  group_name              = var.group_name
  group_id                = var.group_id
  group_description       = var.group_description
  vpc_id                  = var.vpc_id
  vpc_name                = var.vpc_name
  vpc_cidr                = var.vpc_cidr
  priority                = var.priority


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

  # The ingress port list
  ingress_ports = var.ingress_ports

  # The ingress cidr list
  ingress_cidrs = var.ingress_cidrs

  # The ingress port to create rule with port list
  ingress_port_with_cidrs = var.ingress_port_with_cidrs
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

  # The egress port list
  egress_ports = var.egress_ports

  # The egress cidr list
  egress_cidrs = var.egress_cidrs

  # The egress port to create rule with port list
  egress_port_with_cidrs = var.egress_port_with_cidrs
}
