# common variables
variable "region" {
  description = "The region to launch resources."
  default = "cn-hangzhou"
}

# VPC variables
variable "vpc_id" {
  description = "The vpc id used to launch vswitch, security group and instance."
}

# Security Group variables
variable "group_id" {
  description = "The security group id used to launch its rules."
  default = ""
}
variable "group_name" {
  description = "The security group name used to launch a new security group when 'group_id' is not specified."
  default = "TF_Security_Group"
}
variable "group_description" {
  description = "The security group descripton used to launch a new security group when 'group_id' is not specified."
  default = "TF_Security_Group"
}

# Security Group Rules variables
variable "rule_directions" {
  description = "The security group rules direction used to set one or more rules."
  type = "list"
  default = ["ingress"]
}
variable "ip_protocols" {
  description = "The security group rules ip protocol used to set one or more rules."
  type = "list"
  default = ["tcp", "tcp"]
}
variable "policies" {
  description = "The security group policy used to set one or more rules."
  type = "list"
  default = ["accept"]
}
variable "port_ranges" {
  description = "The security group rules port range used to set one or more rules."
  type = "list"
  default = ["-1/-1"]
}
variable "priorities" {
  description = "The security group rules priority used to set one or more rules."
  type = "list"
  default = [1]
}
variable "cidr_ips" {
  description = "The security group rules cidr_ip used to set one or more rules."
  type = "list"
  default = []
}

variable "source_security_group_ids" {
  description = "The source/destination security group ids used to set one or more rules."
  type = "list"
  default = []
}

variable "source_group_owner_accounts" {
  description = "The source/destination security group owner accounts used to set one or more rules."
  type = "list"
  default = [""]
}
