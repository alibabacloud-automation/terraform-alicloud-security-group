

##################################################
# VPC which is used as an argument in complete-sg
##################################################

module "vpc" {
  source       = "alibaba/vpc/alicloud"
  vpc_name     = "my_module_vpc"
  vswitch_name = "my_module_vswitch"
  vswitch_cidrs = [
    "172.16.1.0/24"
  ]
}

resource "alicloud_security_group" "group" {
  name        = "my_security_group"
  vpc_id      = module.vpc.vpc_id
  description = "my_security_group"
}
//
//
//#############################################################
//# Security group which is used as an argument in complete-sg
//#############################################################
//module "main_sg" {
//  source = "alibaba/security-group/alicloud"
//
//  vpc_id = module.vpc.vpc_id
//
//  ingress_cidr_block = "10.10.0.0/16"
//  ingress_rules      = ["https-443-tcp"]
//}
//
//################################################
//# Security group with complete set of arguments
//################################################
module "complete_sg" {
  source              = "alibaba/security-group/alicloud"
  vpc_id              = module.vpc.vpc_id
  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["https-443-tcp"]
  ingress_with_cidr_block = [
    {
      rule       = "postgresql-tcp"
      cidr_block = "2.2.2.2/32"
    },
    {
      rule       = "postgresql-tcp"
      cidr_block = "30.30.30.30/32"
    },
    {
      from_port  = 10
      to_port    = 20
      protocol   = "tcp"
      cidr_block = "10.10.0.0/20"
    },
  ]
  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = alicloud_security_group.group.id
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = "tcp"
      source_security_group_id = alicloud_security_group.group.id
    },
  ]
  egress_cidr_blocks = ["10.10.0.0/16"]
  egress_rules       = ["http-80-tcp"]
  egress_with_cidr_block = [
    {
      rule       = "postgresql-tcp"
      cidr_block = "2.2.2.2/32"
    },
    {
      rule       = "https-443-tcp"
      cidr_block = "30.30.30.30/32"
    },
    {
      from_port  = 10
      to_port    = 20
      protocol   = "tcp"
      cidr_block = "10.10.0.0/20"
    },
  ]
  egress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = alicloud_security_group.group.id
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = "tcp"
      source_security_group_id = alicloud_security_group.group.id
    },
  ]
}


######################################################
# Security group with IPv4 sets of arguments
######################################################
module "ipv4_example" {
  source = "alibaba/security-group/alicloud"

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_block = [
    {
      from_port  = 8080
      to_port    = 8090
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_block = [
    {
      from_port  = 8090
      to_port    = 8100
      protocol   = "tcp"
      cidr_block = "0.0.0.0/0"
    },
  ]
}

######################################################
# Security group with IPv4 sets of arguments
######################################################
module "cidrs_example" {
  source = "alibaba/security-group/alicloud"

  vpc_id              = module.vpc.vpc_id
  existing_group_id   = alicloud_security_group.group.id
  create              = false
  ingress_cidr_blocks = ["2.2.2.2/32", "30.30.30.30/32", "10.10.0.0/20"]
  egress_cidr_blocks  = ["2.2.2.2/32", "30.30.30.30/32", "10.10.0.0/20"]
  ingress_rules       = ["https-443-tcp"]
  egress_rules        = ["https-443-tcp"]
}

module "ports_example" {
  source = "alibaba/security-group/alicloud"

  vpc_id = module.vpc.vpc_id

  ingress_with_ports  = [10, 20, 30]
  egress_with_ports   = [40, 50, 60]
  ingress_cidr_blocks = ["2.2.2.2/32", "10.10.0.0/20"]
  egress_cidr_blocks  = ["30.30.30.30/32", "10.10.0.0/20"]
}
