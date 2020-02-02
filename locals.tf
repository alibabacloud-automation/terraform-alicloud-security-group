locals {
  # set a default sg name
  default_name = "terraform-sg-${replace(random_uuid.this.result, "-", "")}"
  group_name   = var.group_name != "" ? var.group_name : var.this_module_name != "" ? var.this_module_name : var.name != "" ? var.name : local.default_name
  description  = var.group_description != "" ? var.group_description : var.description

  # Get ID of created Security Group
  this_sg_id = var.existing_group_id != "" ? var.existing_group_id : concat(alicloud_security_group.this.*.id, [""])[0]

  # Whether to create ingress and egress rules
  create_rules = var.existing_group_id != "" || var.create ? true : false
}

resource "random_uuid" "this" {}