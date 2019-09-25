variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

variable "this_module_name" {
  default = "terraform-alicloud-security-group"
}

# VPC variables
variable "vpc_name" {
  description = "The vpc name used to create a new vpc when 'vpc_id' is not specified. Default to variable `this_module_name`"
  default     = ""
}

variable "vpc_id" {
  description = "A existing vpc id used to create security group."
  default     = ""
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
  default     = "10.1.0.0/21"
}

# Security Group variables
variable "group_id" {
  description = "The security group id used to launch its rules."
  default     = ""
}

variable "group_name" {
  description = "The security group name used to launch a new security group when 'group_id' is not specified. Default to `this_module_name`"
  default     = ""
}

variable "group_description" {
  description = "The security group descripton used to launch a new security group when 'group_id' is not specified. Default to TF_Security_Group."
  default     = "TF_Security_Group"
}

# Security Group Rules variables
variable "rule_directions" {
  description = "The security group rules direction used to set one or more rules."
  type        = list(string)
  default     = ["ingress"]
}

variable "ip_protocols" {
  description = "The security group rules ip protocol used to set one or more rules."
  type        = list(string)
  default     = ["tcp", "tcp"]
}

variable "policies" {
  description = "The security group policy used to set one or more rules."
  type        = list(string)
  default     = ["accept"]
}

variable "port_ranges" {
  description = "The security group rules port range used to set one or more rules."
  type        = list(string)
  default     = ["-1/-1"]
}

variable "priorities" {
  description = "The security group rules priority used to set one or more rules."
  type        = list(string)
  default     = [1]
}

variable "cidr_ips" {
  description = "The security group rules cidr_ip used to set one or more rules."
  type        = list(string)
  default     = []
}

variable "source_security_group_ids" {
  description = "The source/destination security group ids used to set one or more rules."
  type        = list(string)
  default     = []
}

variable "source_group_owner_accounts" {
  description = "The source/destination security group owner accounts used to set one or more rules."
  type        = list(string)
  default     = [""]
}

