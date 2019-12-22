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

###########################
# Security groups examples
###########################
module "http_sg" {
  source = "../../modules/https-443"
  region = var.region

  name        = "computed-http-sg"
  description = "Security group with HTTP port open for everyone, and HTTPS open just for the default security group"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_with_source_security_group_id = [
    {
      rule                     = "https-443-tcp"
      source_security_group_id = data.alicloud_security_groups.default.ids.0
    },
  ]
}

module "mysql_sg" {
  source = "../../modules/mysql"
  region = var.region

  name        = "computed-mysql-sg"
  description = "Security group with MySQL/Aurora port open for HTTP security group created above (computed)"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = module.http_sg.this_security_group_id
    },
  ]
}