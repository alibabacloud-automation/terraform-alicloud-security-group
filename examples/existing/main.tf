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

resource "alicloud_security_group" "default" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

########################################################
# Security groups WILL NOT be created and WILL use a existing one by these examples
########################################################
module "complete_sg_using_existing" {
  source  = "../../"
  profile = var.profile
  region  = var.region

  existing_group_id = alicloud_security_group.default.id

  create      = false
  name        = "complete-sg"
  description = "Security group with all available arguments set (this is just an example)"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "http_sg_using_existing" {
  source  = "../../modules/http-80"
  profile = var.profile
  region  = var.region

  existing_group_id = alicloud_security_group.default.id

  create      = false
  name        = "http-sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = data.alicloud_vpcs.default.ids.0

  ingress_cidr_blocks = ["0.0.0.0/0"]
}