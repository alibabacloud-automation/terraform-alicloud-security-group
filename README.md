Alicloud ECS Security Group Terraform Module In VPC
terraform-alicloud-security-group
================================================================================

Terraform module which creates [ECS security group within VPC](https://www.alibabacloud.com/help/doc-detail/25387.htm) on Alibaba Cloud.

These types of resources are supported:

* [ECS-VPC Security Group](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)
* [ECS-VPC Security Group Rule](https://www.terraform.io/docs/providers/alicloud/r/security_group_rule.html)

## Features

This module aims to implement **ALL** combinations of arguments supported by Alibaba Cloud and latest stable version of Terraform:
* IPv4 CIDR blocks
* Access from source security groups
* Access from self
* Named rules ([see the rules here](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf))
* Named groups of rules with ingress (inbound) and egress (outbound) ports open for common scenarios (eg, [ssh](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/ssh), [http-80](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/http-80), [mysql](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/mysql), see the whole list [here](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/modules/README.md))
* Conditionally create security group and all required security group rules ("single boolean switch").

Ingress and egress rules can be configured in a variety of ways. See [inputs variables](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/variables.tf) for all supported arguments and [complete example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) for the complete use-case.

If there is a missing feature or a bug - [open an issue](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/issues/new).

## Terraform versions

For Terraform 0.12 use version `v2.*` of this module.

If you are using Terraform 0.11 you can use versions `v1.*`.

## Usage

There are three ways to create security groups using this module:

1. [Specifying predefined rules (HTTP, SSH, etc)](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-predefined-rules)
1. [Specifying custom rules of single cidr block](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-single-cidr-block)
1. [Specifying custom rules of multiple cidr blocks](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-multiple-cidr-blocks)
1. [Specifying custom rules of list ports and cidr blocks](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-list-ports-and-cidr-blocks)
1. [Specifying custom rules of source security group id](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-source-security-group-id)

### Security group with predefined rules

```hcl
module "web_server_sg" {
  source = "terraform-alicloud-modules/security-group/alicloud//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
```

### Security group with custom rules of single cidr block

```hcl
module "service_sg_with_single_cidr" {
  source = "terraform-alicloud-modules/security-group/alicloud"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_block  = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      cidr_block = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_block = "0.0.0.0/0"
    },
  ]
  egress_with_cidr_block = [
    {
      rule       = "postgresql-tcp"
      cidr_block = "2.2.2.2/32"
    },
  ]
}
```

### Security group with custom rules of multiple cidr blocks

```hcl
module "service_sg_with_multi_cidr" {
  source = "terraform-alicloud-modules/security-group/alicloud"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
    },
    {
      rule        = "postgresql-tcp"
    },
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      priority    = 1
    }
  ]
}
```

### Security group with custom rules of list ports and cidr blocks

```hcl
module "service_sg_with_ports" {
  source = "terraform-alicloud-modules/security-group/alicloud"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  
  ingress_with_ports              = [10, 20, 30]
  protocol_for_ingress_with_ports = "tcp"
  priority_for_ingress_with_ports = 2
}
```

### Security group with custom rules of source security group id

```hcl
module "service_sg_with_source_sg_id" {
  source = "terraform-alicloud-modules/security-group/alicloud"

  name        = "user-service"
  description = "Security group for user-service with custom rules of source security group."
  vpc_id      = "vpc-12345678"

  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "sg-12345678"
      priority                 = 1
    },
    {
      from_port                = 10
      to_port                  = 10
      protocol                 = "tcp"
      description              = "Service name"
      source_security_group_id = "sg-98765432"
      priority                 = 2
    },
  ]
  
  egress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "sg-12345678"
    }
  ]
}
```

## Conditional creation

Sometimes you need to have a way to create security group conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create`.

```hcl
# This security group will not be created
module "vote_service_sg" {
  source = "terraform-alicloud-modules/security-group/alicloud"

  create = false
  # ... omitted
}
```

Sometimes you need to have a way to use a existing security group conditionally, the solution is to specify argument `create` to false and specify a existing security group id.

```hcl
# This security group will not be created
module "vote_service_sg" {
  source = "terraform-alicloud-modules/security-group/alicloud"

  existing_group_id = "sg-1234567"
  
  create = false
  # ... omitted
}
```

## Examples

* [Complete Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) shows all available parameters to configure security group.
* [HTTP Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.
* [Disable creation of Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group.
* [Existing creation of Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group and use a existing security group.
* [Dynamic values inside Security Group rules example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/dynamic) shows how to specify values inside security group rules (data-sources and variables are allowed).
* [Computed values inside Security Group rules example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/computed) shows how to specify computed values inside security group rules (solution for `value of 'count' cannot be computed` problem).

## How to add/update rules/groups?

Rules and groups are defined in [rules.tf](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf). Run `update_groups.sh` when content of that file has changed to recreate content of all automatic modules.

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

