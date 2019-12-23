Alicloud ECS Security Group Terraform Module In VPC
terraform-alicloud-security-group
================================================================================

本 module 用于在阿里云创建 [ECS security group within VPC](https://www.alibabacloud.com/help/doc-detail/25387.htm) 模块.

支持了以下资源:

* [ECS-VPC Security Group](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)
* [ECS-VPC Security Group Rule](https://www.terraform.io/docs/providers/alicloud/r/security_group_rule.html)

## 功能

该模块支持以下参数组合，由阿里云与最新稳定版本 Terraform 支持：
* IPv4 CIDR blocks (IPv4 网段)
* Access from source security groups (来自源安全组的访问)
* Access from self (自我访问)
* Named rules ([see the rules here](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf)) (已命名安全组规则)
* Named groups of rules with ingress (inbound) and egress (outbound) ports open for common scenarios (eg, [ssh](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/ssh), [http-80](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/http-80), [mysql](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/mysql), see the whole list [here](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/modules/README.md)) (具有入和出端口的已命名安全组规则可在常见情况下使用)
* Conditionally create security group and all required security group rules ("single boolean switch"). (通过单个布尔开关决定是否创建安全组和所有必需的安全组规则。)

入口和出口规则可以通过多种方式配置.  [inputs variables](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/variables.tf) 为支持的所有参数，以及 [complete example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) 完整示例.

如果缺少功能或发现错误 - [open an issue](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/issues/new).

## Terraform 版本

如果您正在使用 Terraform 0.12，请使用此模块的对应版本`v2.*`.

如果您正在使用 Terraform 0.11，请使用此模块的对应版本`v1.*`.

## 用法

通过以下几种方式来创建安全组及安全组规则:

1. [指定预定义的安全组规则 (HTTP, SSH, etc)](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-predefined-rules)
1. [指定单个网段创建自定义安全组规则](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-single-cidr-block)
1. [指定多个网段创建自定义安全组规则](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-multiple-cidr-blocks)
1. [指定网段及端口列表创建自定义安全组规则](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-list-ports-and-cidr-blocks)
1. [指定源安全组创建自定义安全组规则](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group#security-group-with-custom-rules-of-source-security-group-id)

### 创建安全组与预定义安全组规则

```hcl
module "web_server_sg" {
  source = "alibaba/security-group/alicloud//modules/http-80"

  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
```

### 单个网段创建自定义安全组规则

```hcl
module "service_sg_with_single_cidr" {
  source = "alibaba/security-group/alicloud"

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

### 多个网段创建多组自定义安全组规则

```hcl
module "service_sg_with_multi_cidr" {
  source = "alibaba/security-group/alicloud"

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

### 端口和网段列表创建一组自定义安全组入网规则

```hcl
module "service_sg_with_ports" {
  source = "alibaba/security-group/alicloud"

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

### 通过源安全组ID创建自定义安全组入网规则

```hcl
module "service_sg_with_source_sg_id" {
  source = "alibaba/security-group/alicloud"

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

## 使用场景

有时您需要决定是否创建安全组的开关，但是Terraform不允许在`module`中使用`count`，因此解决方案是指定参数`create`。

```hcl
# This security group will not be created
module "vote_service_sg" {
  source = "alibaba/security-group/alicloud"

  create = false
  # ... omitted
}
```

有时您需要使用现有安全组，解决方案是将参数`create`设置为`false`并指定现有安全组ID。

```hcl
# This security group will not be created
module "vote_service_sg" {
  source = "alibaba/security-group/alicloud"

  existing_group_id = "sg-1234567"
  
  create = false
  # ... omitted
}
```

## 示例

* [完整的安全组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) shows all available parameters to configure security group.
* [HTTP 安全组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.
* [禁用创建安全组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group.
* [现有安全组创建示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group and use a existing security group.
* [动态安全组入网规则示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/dynamic) shows how to specify values inside security group rules (data-sources and variables are allowed).
* [计算值安全组入网规则示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/computed) shows how to specify computed values inside security group rules (solution for `value of 'count' cannot be computed` problem).

## 如何添加/更新安全组入网规则

规则与安全组定义于 [rules.tf](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf)，当该文件的内容已更改以重新创建所有自动模块的内容时，运行 `update_groups.sh`.

作者
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

