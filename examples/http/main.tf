
#############################################################
# Data sources to get VPC and default security group details
#############################################################

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

###########################
# Security groups examples
###########################

#######
# HTTP
#######
module "http_sg" {
  source             = "alibaba/security-group/alicloud/modules/http-80"
  group_name         = "http-sg"
  group_description  = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id             = module.vpc.vpc_id
  ingress_cidr_block = "0.0.0.0/0"
}

#####################
# HTTP with MySQL #1
#####################
module "http_mysql_1_sg" {
  source = "alibaba/security-group/alicloud/modules/http-80"

  group_name        = "http-mysql-1"
  group_description = "Security group with HTTP and MySQL ports open for everybody (IPv4 CIDR)"
  vpc_id            = module.vpc.vpc_id

  ingress_cidr_block = "0.0.0.0/0"

  # Add MySQL rules
  ingress_rules = ["mysql-tcp"]
}

#####################
# HTTP with MySQL #2
#####################

module "http_mysql_2_sg" {
  source = "alibaba/security-group/alicloud/modules/http-80"

  group_name        = "http-mysql-2"
  group_description = "Security group with HTTP and MySQL ports open within current VPC"
  vpc_id            = module.vpc.vpc_id

  # Add mysql rules
  ingress_rules = ["mysql-tcp"]

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_block = module.vpc.cidr_block
}

###########################
# HTTP with egress minimal
###########################
module "http_with_egress_minimal_sg" {
  source = "alibaba/security-group/alicloud/modules/http-80"

  group_name        = "http-with-egress-minimal"
  group_description = "Security group with HTTP ports open within current VPC, and allow egress access to HTTP ports to the whole world"
  vpc_id            = module.vpc.vpc_id

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_block = module.vpc.cidr_block

  # Allow all rules for all protocols
  egress_rules = ["http-80-tcp"]
  # Allow egress rules to access anything (empty list means everything)
  egress_cidr_block = "10.10.10.0/28"
}

###########################
# HTTP with egress limited
###########################
module "http_with_egress_sg" {
  source = "alibaba/security-group/alicloud/modules/http-80"

  group_name        = "http-with-egress"
  group_description = "Security group with HTTP ports open within current VPC, and allow egress access just to small subnet"
  vpc_id            = module.vpc.vpc_id

  # Add mysql rules
  ingress_rules = ["mysql-tcp"]

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_block = module.vpc.cidr_block

  # Allow egress rules to access anything (empty list means everything)
  egress_cidr_block = "10.10.10.0/28"
}
