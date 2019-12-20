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
    module "tf-security-group" {
      source              = "alibaba/security-group/alicloud"
      vpc_id              = module.vpc.vpc_id
      ingress_cidr_blocks = ["10.10.0.0/16"]
      ingress_rules       = ["https-443-tcp"]
      ingress_with_cidr_block = [
        {
          rule       = "postgresql-tcp"
          cidr_block = "2.2.2.2/32"
        },
        {
          rule       = "postgresql-tcp"
          cidr_block = "30.30.30.30/32"
        },
        {
          from_port  = 10
          to_port    = 20
          protocol   = "tcp"
          cidr_block = "10.10.0.0/20"
        },
      ]
      ingress_with_source_security_group_id = [
        {
          rule                     = "mysql-tcp"
          source_security_group_id = alicloud_security_group.group.id
        },
        {
          from_port                = 10
          to_port                  = 10
          protocol                 = "tcp"
          source_security_group_id = alicloud_security_group.group.id
        },
      ]
      egress_cidr_blocks = ["10.10.0.0/16"]
      egress_rules       = ["http-80-tcp"]
      egress_with_cidr_block = [
        {
          rule       = "postgresql-tcp"
          cidr_block = "2.2.2.2/32"
        },
        {
          rule       = "https-443-tcp"
          cidr_block = "30.30.30.30/32"
        },
        {
          from_port  = 10
          to_port    = 20
          protocol   = "tcp"
          cidr_block = "10.10.0.0/20"
        },
      ]
      egress_with_source_security_group_id = [
        {
          rule                     = "mysql-tcp"
          source_security_group_id = alicloud_security_group.group.id
        },
        {
          from_port                = 10
          to_port                  = 10
          protocol                 = "tcp"
          source_security_group_id = alicloud_security_group.group.id
        },
      ]
    }
    ```

2. Setting values for the following variables through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY


## Conditional creation

This module can create Security Group and several Rules.

1. To create an ingress rule using a specified configuration:
    ```hcl
    ingress_with_cidr_block = [
       {
         from_port  = 10
         to_port    = 20
         protocol   = "tcp"
         cidr_block = "10.10.0.0/20"
       },
    ]
    ```
    
1. To create an egress rule using a cidr_block in mapping and rule which specified in rules.tf:
    ```hcl  
    egress_with_cidr_block = [
        {
          rule       = "postgresql-tcp"
          cidr_block = "2.2.2.2/32"
        },
    ]
    ```

1. Create several ingress rules with different field:
    ```hcl
    ingress_with_cidr_block = [
       {
         rule       = "postgresql-tcp"
         cidr_block = "2.2.2.2/32"
       },
       {
         rule       = "postgresql-tcp"
         cidr_block = "30.30.30.30/32"
       },
       {
         from_port  = 10
         to_port    = 20
         protocol   = "tcp"
         cidr_block = "10.10.0.0/20"
       },
    ]
   
    ingress_with_source_security_group_id = [
       {
         rule                     = "mysql-tcp"
         source_security_group_id = alicloud_security_group.group.id
       },
       {
         from_port                = 10
         to_port                  = 10
         protocol                 = "tcp"
         source_security_group_id = alicloud_security_group.group.id
       },
    ]
    egress_with_cidr_block = [
       {
         rule       = "postgresql-tcp"
         cidr_block = "2.2.2.2/32"
       },
       {
         rule       = "https-443-tcp"
         cidr_block = "30.30.30.30/32"
       },
       {
         from_port  = 10
         to_port    = 20
         protocol   = "tcp"
         cidr_block = "10.10.0.0/20"
       },
    ]
    egress_with_source_security_group_id = [
       {
         rule                     = "mysql-tcp"
         source_security_group_id = alicloud_security_group.group.id
       },
       {
         from_port                = 10
         to_port                  = 10
         protocol                 = "tcp"
         source_security_group_id = alicloud_security_group.group.id
       },
    ]
    ```

1. Create ingress and egress rules with field cidr_block and rule which specified in rules.tf:
    ```hcl
    ingress_cidr_blocks = ["10.10.0.0/16"]
    ingress_rules       = ["https-443-tcp"]
    egress_cidr_blocks  = ["10.10.0.0/16"]
    egress_rules        = ["http-80-tcp"]
    ```
    
1. Create ingress and egress rules with field ingress_cidrs/egress_cidrs and default port:
    ```hcl
    ingress_cidr_blocks = ["2.2.2.2/32", "30.30.30.30/32", "10.10.0.0/20"]
    egress_cidr_blocks  = ["2.2.2.2/32", "30.30.30.30/32", "10.10.0.0/20"]
    ingress_rules       = ["https-443-tcp"]
    egress_rules        = ["https-443-tcp"]
    ```

1. Create ingress and egress rules with field ingress_ports/egress_ports and default cidr block:
    ```hcl
    ingress_with_ports  = [10, 20, 30]
    egress_with_ports   = [40, 50, 60]
    ingress_cidr_blocks = ["2.2.2.2/32", "10.10.0.0/20"]
    egress_cidr_blocks  = ["30.30.30.30/32", "10.10.0.0/20"]
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

