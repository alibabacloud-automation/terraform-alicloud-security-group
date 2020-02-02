variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region = var.region
}

#############################################################
# Data sources to get VPC and default security group details
#############################################################

data "alicloud_vpcs" "default" {
  is_default = true
}

data "alicloud_security_groups" "default" {
  name_regex = "default"
  vpc_id     = data.alicloud_vpcs.default.ids.0
}

#############################################################
# Security group which is used as an argument in complete-sg
#############################################################
module "main_sg" {
  source = "../../"

  region = var.region

  name        = "main-sg"
  description = "Security group which is used as an argument in complete-sg"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  ingress_cidr_blocks = ["10.10.0.0/16"]
  ingress_rules       = ["https-443-tcp"]
}

################################################
# Security group with complete set of arguments
################################################
module "complete_sg" {
  source = "../../"

  region = var.region

  name        = "complete-sg"
  description = "Security group with all available arguments set (this is just an example)"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  tags = {
    Cash       = "king"
    Department = "kingdom"
  }

  # Default CIDR blocks, which will be used for all ingress rules in this module. Typically these are CIDR blocks of the VPC.
  # If this is not specified then no CIDR blocks will be used.
  ingress_cidr_blocks = ["10.10.0.0/16"]

  # Open for all CIDRs defined in ingress_cidr_blocks
  # Using priority_for_ingress_rules to specify one priority for all of ports. Or can use default_ingress_priority
  ingress_rules              = ["https-443-tcp"]
  priority_for_ingress_rules = 2

  # Open to CIDRs blocks (rule or cidr_blocks+from_port+to_port+protocol+description+priority)
  ingress_with_cidr_blocks = [
    {
      rule        = "dns-udp"
      priority    = 1
      cidr_blocks = "10.10.0.0/20,10.11.0.0/20"
    },
    {
      // Using ingress_cidr_blocks to set cidr_blocks
      from_port   = 53
      to_port     = 53
      protocol    = "tcp"
      description = "Service name"
      priority    = 2
    },
    {
      rule        = "ntp-udp"
      cidr_blocks = "10.10.0.0/20"
    }
  ]

  # Open for security group id (rule or from_port+to_port+protocol+description+priority)
  # The source_security_group_id can be from existing or computed.
  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = data.alicloud_security_groups.default.ids.0
      priority                 = 1
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = "tcp"
      description              = "Service name"
      source_security_group_id = module.main_sg.this_security_group_id
      priority                 = 2
    },
  ]

  # Open to a list ports ( each item 'from' and 'to' have the same port value. e.g [10, 20, 30] means port range are 10/10, 20/20, 30/30)
  ingress_ports = [50, 150]
  ingress_with_cidr_blocks_and_ports = [
    {
      ports       = "10,20,30"
      protocol    = "tcp"
      priority    = 1
      cidr_blocks = "10.10.0.0/20,10.11.0.0/20"
    },
    {
      # Using ingress_ports to set ports
      protocol    = "udp"
      description = "ingress for tcp"
      cidr_blocks = "172.10.0.0/20"
    },
    {
      # Using ingress_ports and ingress_cidr_blocks to set ports and cidr_blocks
      protocol    = "icmp"
      priority    = 20
      description = "ingress for icmp"
    }
  ]

  //  # Default CIDR blocks, which will be used for all egress rules in this module. Typically these are CIDR blocks of the VPC.
  //  # If this is not specified then no CIDR blocks will be used.
  egress_cidr_blocks = ["10.10.0.0/16"]

  # Open for all CIDRs defined in egress_cidr_blocks
  # Using priority_for_egress_rules to specify one priority for all of ports. Or can use default_egress_priority
  egress_rules              = ["http-80-tcp"]
  priority_for_egress_rules = 2

  # Open to CIDRs blocks (rule or cidr_blocks+from_port+to_port+protocol+description+priority)
  egress_with_cidr_blocks = [
    {
      rule        = "ipsec-500-udp"
      priority    = 1
      cidr_blocks = "10.10.0.0/20,10.11.0.0/20"
    },
    {
      rule        = "ipsec-4500-udp"
      cidr_blocks = "10.10.0.0/20"
    },
    {
      // Using egress_cidr_blocks to set cidr_blocks
      from_port   = 10
      to_port     = 20
      protocol    = "udp"
      description = "Service name"
      priority    = 2
    },
  ]
  # Open for security group id (rule or from_port+to_port+protocol+description+priority)
  # The source_security_group_id can be from existing or computed.
  egress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = data.alicloud_security_groups.default.ids.0
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = "tcp"
      source_security_group_id = module.main_sg.this_security_group_id
      priority                 = 2
    },
  ]

  # Open to a list ports ( each item 'from' and 'to' have the same port value. e.g [10, 20, 30] means port range are 10/10, 20/20, 30/30)
  egress_ports = [90, 100, 110]
  egress_with_cidr_blocks_and_ports = [
    {
      ports       = "50,60"
      protocol    = "tcp"
      priority    = 1
      cidr_blocks = "10.10.0.0/20,10.11.0.0/20"
    },
    {
      # Using egress_ports to set ports
      protocol    = "udp"
      description = "egress for tcp"
      cidr_blocks = "172.10.0.0/20"
    },
    {
      # Using egress_ports and egress_cidr_blocks to set ports and cidr_blocks
      protocol    = "icmp"
      priority    = 20
      description = "egress for icmp"
    }
  ]
}
