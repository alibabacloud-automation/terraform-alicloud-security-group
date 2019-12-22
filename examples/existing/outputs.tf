output "this_security_group_id" {
  description = "The ID of the security group"
  value       = module.complete_sg_using_existing.this_security_group_id
}