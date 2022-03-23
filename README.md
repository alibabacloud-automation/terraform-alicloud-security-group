Alicloud ECS Security Group Terraform Module In VPC   
terraform-alicloud-security-group
================================================================================

English | [简体中文](README-CN.md)

Terraform module which creates [ECS security group within VPC](https://www.alibabacloud.com/help/doc-detail/25387.htm) on Alibaba Cloud.

These types of resources are supported:

* [ECS-VPC Security Group](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)
* [ECS-VPC Security Group Rule](https://www.terraform.io/docs/providers/alicloud/r/security_group_rule.html)

## Features

This module aims to implement **ALL** combinations of arguments supported by Alibaba Cloud and latest stable version of Terraform:
* IPv4 CIDR blocks
* Access from source security groups
* Named rules ([see the rules here](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf))
* Named groups of rules with ingress (inbound) and egress (outbound) ports open for common scenarios (eg, [ssh](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/ssh), [http-80](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/http-80), [mysql](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/mysql), see the whole list [here](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/modules/README.md))
* Conditionally create security group and all required security group rules ("single boolean switch").

Ingress and egress rules can be configured in a variety of ways. See [inputs variables](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/variables.tf) for all supported arguments and [complete example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) for the complete use-case.

If there is a missing feature or a bug - [open an issue](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/issues/new).

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
  source  = "alibaba/security-group/alicloud//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
```

### Security group with custom rules of multiple cidr blocks

```hcl
module "service_sg_with_multi_cidr" {
  source  = "alibaba/security-group/alicloud"

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
      cidr_blocks = "10.10.0.0/16,10.11.0.0/16,10.12.0.0/16"
      priority    = 2
    },
    {
      rule        = "postgresql-tcp"
      priority    = 2
      cidr_blocks = "10.13.0.0/16,10.14.0.0/16"
    },
    {
      // Using ingress_cidr_blocks to set cidr_blocks
      rule = "postgresql-tcp"
    },
  ]
  egress_cidr_blocks      = ["10.10.0.0/16"]
  egress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8090
      protocol    = "tcp"
      description = "User-service ports"
      priority    = 1
      cidr_blocks = "10.13.0.0/16,10.14.0.0/16"
    },
    {
      // Using egress_cidr_blocks to set cidr_blocks
      rule = "postgresql-tcp"
    },
  ]
}
```

### Security group with custom rules of list ports and cidr blocks

```hcl
module "service_sg_with_ports" {
  source  = "alibaba/security-group/alicloud"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  
  ingress_ports = [50, 150]
  ingress_with_cidr_blocks_and_ports = [
    {
      ports       = "10,20,30"
      protocol    = "tcp"
      priority    = 1
      cidr_blocks = "10.10.0.0/20,10.11.0.0/20"
    },
    {
      # Using ingress_ports to set ports
      protocol    = "udp"
      description = "ingress for tcp"
      cidr_blocks = "172.10.0.0/20"
    },
    {
      # Using ingress_ports and ingress_cidr_blocks to set ports and cidr_blocks
      protocol    = "icmp"
      priority    = 20
      description = "ingress for icmp"
    }
  ]
}
```

### Security group with custom rules of source security group id

```hcl
module "service_sg_with_source_sg_id" {
  source  = "alibaba/security-group/alicloud"

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

Create an enterprise Security Group

```hcl
module "web_server_sg" {
  source = "alibaba/security-group/alicloud//modules/http-80"

  name                = "web-server"
  description         = "An enterprise security group created by terraform."
  vpc_id              = "vpc-12345678"
  security_group_type = "enterprise"
}
```

Sometimes you need to have a way to create security group conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create`.

```hcl
# This security group will not be created
module "vote_service_sg" {
  source  = "alibaba/security-group/alicloud"

  create = false
  # ... omitted
}
```

Sometimes you need to have a way to use a existing security group conditionally, the solution is to specify argument `create` to false and specify a existing security group id.

```hcl
# This security group will not be created
module "vote_service_sg" {
  source  = "alibaba/security-group/alicloud"

  existing_group_id = "sg-1234567"
  
  create = false
  # ... omitted
}
```

## Notes
From the version v2.4.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/security-group"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 2.3.0:

```hcl
module "web_server_sg" {
  source  = "alibaba/security-group/alicloud"

  version     = "2.3.0"
  region      = "cn-hangzhou"
  profile     = "Your-Profile-Name"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
  // ...
}
```

If you want to upgrade the module to 2.4.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region  = "cn-hangzhou"
   profile = "Your-Profile-Name"
}
module "web_server_sg" {
  source  = "alibaba/security-group/alicloud"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}

module "web_server_sg" {
  source  = "alibaba/security-group/alicloud"

  providers = {
    alicloud = alicloud.hz
  }
  
  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Examples

* [Complete Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) shows all available parameters to configure security group.
* [HTTP Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.
* [Disable creation of Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group.
* [Existing creation of Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group and use a existing security group.
* [Dynamic values inside Security Group rules example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/dynamic) shows how to specify values inside security group rules (data-sources and variables are allowed).
* [Computed values inside Security Group rules example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/computed) shows how to specify computed values inside security group rules (solution for `value of 'count' cannot be computed` problem).
* [Enterprise Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/enterprise-group) shows how to create an enterprise security group.

## How to add/update rules/groups?

Rules and groups are defined in [rules.tf](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf). Run `update_groups.sh` when content of that file has changed to recreate content of all automatic modules.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.56.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)