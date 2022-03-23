data "alicloud_zones" "default" {
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones.0.id]
}

module "security_group" {
  source = "../.."

  create = true

  name                = var.name
  vpc_id              = module.vpc.this_vpc_id
  description         = var.description
  security_group_type = "normal"
  tags                = var.tags

}

module "complete_sg" {
  source = "../.."

  #alicloud_security_group
  create = true

  name                = var.name
  vpc_id              = module.vpc.this_vpc_id
  description         = var.description
  security_group_type = "normal"
  tags                = var.tags

  #alicloud_security_group_rule
  ingress_rules              = ["https-443-tcp"]
  ingress_cidr_blocks        = ["10.10.0.0/16"]
  priority_for_ingress_rules = 1
  default_ingress_priority   = 50

  ingress_with_cidr_blocks = [
    {
      cidr_blocks = "10.10.0.0/20"
      priority    = 1
      rule        = "dns-udp"
    },
    {
      priority    = 2
      from_port   = 53
      to_port     = 53
      protocol    = "tcp"
      description = var.rule_description
    }
  ]
  ingress_with_cidr_blocks_and_ports = [
    {
      cidr_blocks = "10.11.0.0/20"
      priority    = 1
      ports       = "10"
      protocol    = "tcp"
    },
    {
      cidr_blocks = "172.10.0.0/20"
      protocol    = "udp"
      description = var.rule_description
    }
  ]
  ingress_ports = [50]
  ingress_with_source_security_group_id = [
    {
      source_security_group_id = module.security_group.this_security_group_id
      priority                 = 1
      rule                     = "mysql-tcp"
    },
    {
      source_security_group_id = module.security_group.this_security_group_id
      priority                 = 2
      from_port                = 10
      to_port                  = 10
      protocol                 = "tcp"
      description              = var.rule_description
    },
  ]

  egress_rules              = ["http-80-tcp"]
  egress_cidr_blocks        = ["10.10.0.0/16"]
  priority_for_egress_rules = 1
  default_egress_priority   = 50
  egress_with_cidr_blocks = [
    {
      cidr_blocks = "10.10.0.0/20"
      priority    = 1
      rule        = "ipsec-500-udp"
    },
    {
      priority    = 2
      from_port   = 10
      to_port     = 20
      protocol    = "udp"
      description = var.rule_description
    }
  ]
  egress_with_cidr_blocks_and_ports = [
    {
      cidr_blocks = "10.10.0.0/20"
      priority    = 1
      ports       = "50"
      protocol    = "tcp"
    },
    {
      cidr_blocks = "172.10.0.0/20"
      protocol    = "udp"
      description = var.rule_description
    }
  ]
  egress_ports = [90]
  egress_with_source_security_group_id = [
    {
      source_security_group_id = module.security_group.this_security_group_id
      priority                 = 1
      rule                     = "mysql-tcp"
    },
    {
      source_security_group_id = module.security_group.this_security_group_id
      priority                 = 2
      from_port                = 10
      to_port                  = 10
      protocol                 = "tcp"
      description              = var.rule_description
    }
  ]

}