

##################################################
# VPC which is used as an argument in complete-sg
##################################################
module "vpc" {
  source       = "alibaba/vpc/alicloud"
  vpc_name     = "my_terratest_vpc"
  vswitch_name = "my_terratest_vswitch"
  vswitch_cidrs = [
    "172.16.1.0/24"
  ]
}

resource "alicloud_security_group" "group" {
  name        = "my_security_group"
  vpc_id      = module.vpc.vpc_id
  description = "my_security_group"
}


#############################################################
# Security group which is used as an argument in complete-sg
#############################################################
module "main_sg" {
  source = "../../"

  vpc_id = module.vpc.vpc_id

  ingress_cidr_block = "10.10.0.0/16"
  ingress_rules      = ["https-443-tcp"]
}

################################################
# Security group with complete set of arguments
################################################
module "complete_sg" {
  source = "../../"

  vpc_id = module.vpc.vpc_id

  # Default CIDR blocks, which will be used for all ingress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  ingress_cidr_block = "10.10.0.0/16"

  # Prefix list ids to use in all ingress rules in this module.
  # ingress_prefix_list_ids = ["pl-123456"]
  # Open for all CIDRs defined in ingress_cidr_blocks
  ingress_rules = [
  "https-443-tcp"]

  # Use computed value here (eg, `${module...}`). Plain string is not a real use-case for this argument.

  # Open to CIDRs blocks (rule or from_port+to_port+protocol)
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

  # Open for security group id (rule or from_port+to_port+protocol)
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

  # Default CIDR blocks, which will be used for all egress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  egress_cidr_block = "10.10.0.0/16"

  # Prefix list ids to use in all egress rules in this module.
  # egress_prefix_list_ids = ["pl-123456"]
  # Open for all CIDRs defined in egress_cidr_blocks
  egress_rules = [
  "http-80-tcp"]

  # Open to CIDRs blocks (rule or from_port+to_port+protocol)
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

  # Open for security group id (rule or from_port+to_port+protocol)
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
# Security group with IPv4 and IPv6 sets of arguments
######################################################
module "ipv4_example" {
  source = "../../"

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

  ingress_cidr_block = "10.10.0.0/16"
}
