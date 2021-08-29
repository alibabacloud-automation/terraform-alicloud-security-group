terraform-alicloud-security-group
================================================================================

本 Module 用于在阿里云的 VPC 下创建一个[安全组（Security Group）](https://help.aliyun.com/document_detail/25387.html)

本 Module 支持创建以下资源:

* [安全组（Security Group）](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)
* [安全组规则（Security Group Rule）](https://www.terraform.io/docs/providers/alicloud/r/security_group_rule.html)

## 功能

本模块在稳定的 Terraform 及 阿里云 Provider 版本下，支持通过多种参数的不同组合实现对安全组的创建和安全组规则的批量添加：

* IPv4 CIDR blocks (设置 IPv4 网段来添加安全组规则)
* Access from source security groups (设置源安全组 ID 来添加安全组规则)
* Named rules (通过对安全组规则进行命名来直接在模板中引用和添加安全组规则：https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf)
* 常见的安全组规则，如 [ssh](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/ssh), [http-80](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/http-80), [mysql](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/modules/mysql)
* 条件控制是否创建一个新的安全组和为安全组添加规则

入口和出口规则可以通过多种方式配置和添加，可以参考所有的参数 [inputs variables](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/variables.tf)，和本 Module 提供的[完整的 Example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete)。

如果在使用过程中，发现 Module 有错误或者有无法满足您的需求，可以直接提交Issues：[open an issue](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/issues/new).

## 用法

本 Module 支持以下几种方式来创建安全组及安全组规则:

### 使用预定义安全组规则

```hcl
module "web_server_sg" {
  source  = "alibaba/security-group/alicloud//modules/http-80"
  profile = "Your-Profile-Name"
  region  = "cn-beijing"
  
  name        = "web-server"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks = ["10.10.0.0/16"]
}
```

### 使用自定义的安全组规则，通过一个网段列表指定多个网段

```hcl
module "service_sg_with_multi_cidr" {
  source  = "alibaba/security-group/alicloud"
  profile = "Your-Profile-Name"
  region  = "cn-beijing"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC"
  vpc_id      = "vpc-12345678"

  ingress_cidr_blocks      = ["10.10.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      // 显式指定 cidr_blocks
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
      // 使用 ingress_cidr_blocks 来指定 cidr_blocks
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
      // 使用 egress_cidr_blocks 来指定 cidr_blocks
      rule = "postgresql-tcp"
    },
  ]
}
```

### 使用自定义的安全组规则，通过一个网段列表指定多个网段，一个端口列表指定多个端口（此时每个规则的起始端口和终止端口是相同的）

```hcl
module "service_sg_with_ports" {
  source  = "alibaba/security-group/alicloud"
  profile = "Your-Profile-Name"
  region  = "cn-beijing"

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
      // 使用 ingress_ports 来指定 ports
      protocol    = "udp"
      description = "ingress for tcp"
      cidr_blocks = "172.10.0.0/20"
    },
    {
      // 使用 ingress_ports 和 ingress_cidr_blocks 来指定 ports 和 cidr_blocks
      protocol    = "icmp"
      priority    = 20
      description = "ingress for icmp"
    }
  ]
}
```

### 使用自定义的安全组规则，执行一个源安全组ID，实现组组授权

```hcl
module "service_sg_with_source_sg_id" {
  source  = "alibaba/security-group/alicloud"
  profile = "Your-Profile-Name"
  region  = "cn-beijing"

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

## 条件判断

创建一个企业级安全组。

```hcl
module "web_server_sg" {
  source = "alibaba/security-group/alicloud//modules/http-80"
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"

  name                = "web-server"
  description         = "An enterprise security group created by terraform."
  vpc_id              = "vpc-12345678"
  security_group_type = "enterprise"
}
```

有时可能不需要创建一个新的安全组，但是 Terraform Module 中又不能指定 `count`，此时可以之间通过设置 `create = false` 来实现。

```hcl
# This security group will not be created
module "vote_service_sg" {
  source  = "alibaba/security-group/alicloud"
  profile = "Your-Profile-Name"
  region  = "cn-beijing"

  create = false
  # ... omitted
}
```

如果想使用本 Module 对存量的安全组增加安全组规则，可以设置`create = false`，并通过 `existing_group_id` 指定一个存量的安全组ID。

```hcl
# This security group will not be created
module "vote_service_sg" {
  source  = "alibaba/security-group/alicloud"
  profile = "Your-Profile-Name"
  region  = "cn-beijing"

  existing_group_id = "sg-1234567"
  
  create = false
  # ... omitted
}
```

## 注意事项
本Module从版本v2.4.0开始已经移除掉如下的 provider 的显示设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/security-group"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 2.3.0:

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

如果你想对正在使用中的Module升级到 2.4.0 或者更高的版本，那么你可以在模板中显示定义一个系统过Region的provider：
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
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显示指定这个provider：

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

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## 示例

* [完整的安全组规则使用示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) shows all available parameters to configure security group.
* [HTTP 安全组规则使用示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.
* [不创建安全组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group.
* [使用现有安全组添加规则示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/disabled) shows how to disable creation of security group and use a existing security group.
* [使用动态安全组增加入网规则示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/dynamic) shows how to specify values inside security group rules (data-sources and variables are allowed).
* [新增的安全组来指定源安全组ID示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/computed) shows how to specify computed values inside security group rules (solution for `value of 'count' cannot be computed` problem).
* [创建企业级安全组示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/enterprise-group) shows how to create an enterprise security group.

## 如何添加/更新安全组入网规则

规则与安全组定义于 [rules.tf](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/blob/master/rules.tf)。如果修改了该文件，并想将其应用到所有的已经生成的规则上，可直接运行 `update_groups.sh`.

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

