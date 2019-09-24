// Output the ID of the new VPC and Security Group created
output "vpc_id" {
  value = var.vpc_id
}

output "security_group_id" {
  value = var.group_id == "" ? join(",", alicloud_security_group.group.*.id) : var.group_id
}

