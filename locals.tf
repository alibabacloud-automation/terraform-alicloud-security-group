locals {
  default_name = "terraform-sg-${random_uuid.this.result}"
  group_id     = var.existing_group_id != "" ? var.existing_group_id : var.create ? concat(alicloud_security_group.this.*.id, [""])[0] : ""
  group_name   = var.group_name != "" ? var.group_name : var.this_module_name != "" ? var.this_module_name : var.name != "" ? var.name : local.default_name
  description  = var.group_description != "" ? var.group_description : var.description

}

resource "random_uuid" "this" {}