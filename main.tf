provider "alicloud" {
  version                 = ">=1.56.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/security-group"
}

// Security Group Resource for Module
resource "alicloud_security_group" "this" {
  count       = var.create ? 1 : 0
  name        = local.group_name
  vpc_id      = var.vpc_id
  description = local.description
  tags        = var.tags
}
