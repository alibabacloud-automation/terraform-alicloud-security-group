Alicloud ECS Security Group Terraform Module In VPC
terraform-alicloud-security-group
================================================================================

A terraform module to provide ECS Security Group in Alicloud VPC.

- It assumes you have one VPC and VSwitch and you want to put the new instances to the VPC. If not, you can launch a new one by module [terraform-alicloud-vpc](https://github.com/alibaba/terraform-alicloud-vpc)
- The module contains one Security Group and several Security Group Rules.
- The module will launch a new Security Group using its own parameters.

`NOTE`:
1. The number of Security Group rules depends on the size of `ingress_with_cidr_block`, `ingress_with_source_security_group_id`, `egress_with_cidr_block` and `egress_with_source_security_group_id`
2. All of the Security Group rules' network type are `intranet`
3. Key-Value `cidr_block` should be set in mapping `ingress_with_cidr_block` and `egress_with_cidr_block`, or use `ingress_cidr_block` / `egress_cidr_block` to create all cidr rules; Key-Value `source_security_group_id` should be set in mapping `ingress_with_source_security_group_id` and `egress_with_source_security_group_id`, otherwise there is no rules can be added in this way.


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

    ```hcl
    module "security_group" {
      source            = "alibaba/security-group/alicloud"
      vpc_id            = data.alicloud_vpcs.this.ids.0
      existing_group_id = data.alicloud_security_groups.this.ids.0
      ingress_rules     = ["https-443-tcp", "http-80-tcp"]
      ingress_with_cidr_block = [
        {
          rule       = "postgresql-tcp"
          cidr_block = "2.2.2.2/32"
        },
        {
          rule       = "nfs-tcp"
          cidr_block = "30.30.30.30/32"
          priority   = 10
        },
        {
          from_port  = 10
          to_port    = 20
          protocol   = "tcp"
          cidr_block = "10.10.0.0/20"
          priority   = 20
        }
      ]
      ingress_with_cidr_blocks = [
        {
          rule = "oracle-db-tcp"
        },
        {
          from_port = 110
          to_port   = 220
          protocol  = "tcp"
          priority  = 10
        }
      ]
      ingress_with_ports  = [8080, 8081, 8082]
      ingress_cidr_blocks = ["10.10.1.0/16", "10.10.2.0/16", "10.10.3.0/16"]
    }
    ```

2. Setting values for the following variables through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY


## Conditional creation

This module can create Security Group and several Rules.

1. 使用 `ingress_rules` 和 `ingress_cidr_blocks` 批量创建安全组入网规则:

    ```hcl
    ingress_rules       = ["https-443-tcp", "http-80-tcp"]
    ingress_cidr_blocks = ["10.10.1.0/16", "10.10.2.0/16", "10.10.3.0/16"]
    ```
    
2. 使用 `ingress_with_cidr_block` 批量创建安全组入网规则:

    ```hcl  
    ingress_with_cidr_block = [
        {
          rule       = "postgresql-tcp"
          cidr_block = "2.2.2.2/32"
        },
        {
          rule       = "oracle-db-tcp"
          cidr_block = "30.30.30.30/32"
          priority   = 10
        },
        {
          from_port  = 10
          to_port    = 20
          protocol   = "tcp"
          cidr_block = "10.10.0.0/20"
          priority   = 20
        }
    ]
    ```
    
    注意：列表`ingress_with_cidr_block`中的每个元素的`cidr_block`必须要指定，如果没指定，不会默认从`ingress_cidr_blocks`中读取，此时会在创建的时候因为缺少`cidr_block`而报错。

3. 使用 `ingress_with_cidr_blocks` 和 `ingress_cidr_blocks` 批量创建安全组入网规则:

    ```hcl
    ingress_with_cidr_blocks = [
        {
          rule = "oracle-db-tcp"
        },
        {
          from_port = 110
          to_port   = 220
          protocol  = "tcp"
          priority  = 10
        }
    ]
    ingress_cidr_blocks = ["10.10.1.0/16", "10.10.2.0/16", "10.10.3.0/16"]
    ```
    
    注意：列表`ingress_with_cidr_blocks`中的每个元素的`cidr_block`会被忽略，`cidr_block` 的值会从`ingress_cidr_blocks` 中读取。

3. 使用 `ingress_with_ports` 和 `ingress_cidr_blocks` 批量创建安全组入网规则:

    ```hcl
    ingress_with_ports  = [8080, 8081, 8082]
    ingress_cidr_blocks = ["10.10.1.0/16", "10.10.2.0/16", "10.10.3.0/16"]
    ```
    
    
Examples
-----
1. [Complete Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/complete) shows all available parameters to configure security group. 
1. [HTTP Security Group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-security-group/tree/master/examples/http) shows more applicable security groups for common web-servers.


How to add/update rules/groups?
-------------------------------
Rules and groups are defined in rules.tf. Run update_groups.sh when content of that file has changed to recreate content of all automatic modules.


## Outputs

| Name | Description |
|------|-------------|
| this_security_group_id | The ID of the Service |
| this_security_group_vpc_id | The VPC ID |
| this_security_group_name | The name of the security group |
| this_security_group_description | The description of the security group |

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

