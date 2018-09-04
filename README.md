Alicloud ECS Security Group Terraform Module In VPC
terraform-alicloud-security-group
================================================================================

A terraform module to provide ECS Security Group in Alicloud VPC.

- It assumes you have one VPC and VSwitch and you want to put the new instances to the VPC. If not, you can launch a new one by module [terraform-alicloud-vpc](https://github.com/alibaba/terraform-alicloud-vpc)
- The module contains one Security Group and several Security Group Rules.
- If Security Group is not specified, the module will launch a new one using its own parameters.

`NOTE`:
1. The number of Security Group rules depends on the size of `ip_protocols` and `cidr_ips` or `source_security_group_ids`
2. All of the Security Group rules' network type are `intranet`
3. At least one of `cidr_ips` and `source_security_group_ids` should be set, otherwise there is no rules can be added


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


         module "tf-security-group" {
            source = "alibaba/security-group/alicloud"

            region = "${var.region}"

            vpc_name = "my_module_vpc"
            vpc_cidr = "10.16.0.0/12"

            sg_name = "my_module_group"
            rule_directions = ["ingress"]
            ip_protocols = ["tcp", "tcp", "udp"]
            policies = ["accept", "accept", "drop"]
            port_ranges = ["80/80", "22/22", "8080/8080"]
            priorities = [1, 2]
            cidr_ips = ["100.20.10.24/10"]
            source_security_group_ids = [var.source_security_group_id_1, var.source_security_group_id_2]
         }

2. Setting values for the following variables through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY

`NOTE`:If the authorization object is the existing security groups, you need to input `source_security_group_ids`

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/alibaba/terraform-provider)
* [Terraform-Provider-Alicloud Release](https://github.com/alibaba/terraform-provider/releases)
* [Terraform-Provider-Alicloud Latest Docs](http://47.95.33.19:4567/docs/providers/alicloud/)
