#################
# Security group
#################
variable "name" {
  description = "Name of security group. It is used to create a new security group. A random name prefixed with 'terraform-sg-' will be set if it is empty."
  type        = string
  default     = "tf-testacc-sg"
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "tf-testacc-description"
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default = {
    Name = "SG"
  }
}

##########
# Ingress
##########
variable "rule_description" {
  description = "The description of the security group rule."
  type        = string
  default     = "tf-testacc-rulw-description"
}