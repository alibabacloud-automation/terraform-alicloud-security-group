
provider "alicloud" {
  region = "cn-hangzhou"
}

#######################################
# Create an enterprise security group
#######################################
data "alicloud_vpcs" "default" {
  is_default = true
}

module "enterprise_sg" {
  source              = "../../"
  vpc_id              = data.alicloud_vpcs.default.ids[0]
  security_group_type = "enterprise"
  description         = "enterprise security group"
}

