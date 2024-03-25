variable "region" {
  default = "cn-hangzhou"
}

variable "profile" {
  default = "default"
}

provider "alicloud" {
  region  = var.region
  profile = var.profile
}

#######################################
# Create an enterprise security group
#######################################
data "alicloud_vpcs" "default" {
  is_default = true
}

module "enterprise_sg" {
  source              = "../../"
  profile             = var.profile
  region              = var.region
  vpc_id              = data.alicloud_vpcs.default.ids.0
  security_group_type = "enterprise"
  description         = "enterprise security group"
}

