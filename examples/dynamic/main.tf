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
  name_regex = "default-NODELETING"
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

  name        = "dynamic-http-sg"
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