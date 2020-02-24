variable "profile" {
  default = "default"
}
variable "region" {
  default = "cn-hangzhou"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
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

###########################
# Security groups examples
###########################

#######
# HTTP
#######
module "http_sg" {
  source  = "../../modules/http-80"
  profile = var.profile
  region  = var.region

  name        = "http-sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

#####################
# HTTP with MySQL #1
#####################
module "http_mysql_1_sg" {
  source  = "../../modules/http-80"
  profile = var.profile
  region  = var.region

  name = "http-mysql-1"

  description = "Security group with HTTP and MySQL ports open for everybody (IPv4 CIDR)"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Add MySQL rules
  ingress_rules = ["mysql-tcp"]
}

#####################
# HTTP with MySQL #2
#####################
module "http_mysql_2_sg" {
  source  = "../../modules/http-80"
  profile = var.profile
  region  = var.region

  name        = "http-mysql-2"
  description = "Security group with HTTP and MySQL ports open within current VPC"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  # Add mysql rules
  ingress_rules = ["mysql-tcp"]

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_blocks = [data.alicloud_vpcs.default.vpcs.0.cidr_block]
}

###########################
# HTTP with egress minimal
###########################
module "http_with_egress_minimal_sg" {
  source  = "../../modules/http-80"
  profile = var.profile
  region  = var.region

  name        = "http-with-egress-minimal"
  description = "Security group with HTTP ports open within current VPC, and allow egress access to HTTP ports to the whole world"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_blocks = [data.alicloud_vpcs.default.vpcs.0.cidr_block]

  # Allow all rules for all protocols
  egress_rules = ["http-80-tcp"]
}

###########################
# HTTP with egress limited
###########################
module "http_with_egress_sg" {
  source  = "../../modules/http-80"
  profile = var.profile
  region  = var.region

  name        = "http-with-egress"
  description = "Security group with HTTP ports open within current VPC, and allow egress access just to small subnet"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  # Add mysql rules
  ingress_rules = ["mysql-tcp"]

  # Allow ingress rules to be accessed only within current VPC
  ingress_cidr_blocks = [data.alicloud_vpcs.default.vpcs.0.cidr_block]

  # Allow egress rules to access anything (empty list means everything)
  egress_cidr_blocks = ["10.10.10.0/28"]
}