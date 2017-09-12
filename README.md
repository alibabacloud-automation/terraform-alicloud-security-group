Alicloud ECS Security Group Terraform Module In VPC
terraform-alicloud-security-group
================================================================================

A terraform module to provide ECS Security Group in Alicloud VPC.

- It assumes you have one VPC and VSwitch and you want to put the new instances to the VPC. If not, you can launch a new one by module [terraform-alicloud-vpc](https://github.com/alibaba/terraform-alicloud-vpc)
- The module contains one Security Group and several Security Group Rules.
- If Security Group is not specified, the module will launch a new one using its own parameters.


Module Input Variables
----------------------

The module aim to create one or more instances and disks in the VPC. Its input variables contains VPC, VSwitch, Security Group, Security Group Rules, ECS Disks and ECS Instances.

#### Common Input vairables

- `alicloud_access_key` - The Alicloud Access Key ID to launch resources
- `alicloud_secret_key` - The Alicloud Access Secret Key to launch resources
- `region` - The region to launch resources

#### VPC Input Variables

- `vpc_id` - VPC ID used to launch a new Security Group

#### Security Group Input Variables

- `group_id` - Security Group ID to configure rules and launch new ECS instances
- `group_name` - Security Group name to mark a new Security Group when `group_id` is not specified - default to "TF_Security_Group"
- `group_description` - Security Group description used to launch a new security group when `group_id` is not specified - default to "A new Security Group created by Terrafrom module tf-alicloud-security-group"

#### Security Group Rules Input Variables
- `ip_protocols` - List of IP protocols to configure Security Group rules - item choices: ["tcp", "udp", "icmp", "gre", "all"]
- `rule_directions` - List of directions to configure Security Group rules - item choices: ["ingress", "egress"] - default to ["ingress"]
- `policies` - List of policies to configure Security Group rules - item choices: ["accept", "drop"] - default to ["accept"]
- `port_ranges` - List of port ranges to configure Security Group rules - valid value "1/65535" for "tcp/udp" and "-1/-1" to other protocols - default to ["-1/-1"]
- `priorities` - List of priorities to configure Security Group rules - item choices: [1-100] - default to [1]
- `cidr_ips` - List of CIDR IPs to configure Security Group rules
- `source_security_group_ids` - List of source/destination security group ids
- `source_group_owner_accounts` - List of source/destination security group owner accounts used to across user authorization security group


`NOTE`:
1. The number of Security Group rules depends on the size of `ip_protocols` and `cidr_ips` or `source_security_group_ids`
2. All of the Security Group rules' network type are `intranet`
3. At least one of `cidr_ips` and `source_security_group_ids` should be set, otherwise there is no rules can be added


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

       module "tf-security-group" {
          source = "github.com/terraform-community-modules/terraform-alicloud-security-group"

          alicloud_access_key = "${var.alicloud_access_key}"
          alicloud_secret_key = "${var.alicloud_secret_key}"
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

2. Setting values for the following variables, either through terraform.tfvars or environment variables or -var arguments on the CLI

- alicloud_access_key
- alicloud_secret_key
- region

If the authorization object is the existing security groups, you need to input `source_security_group_ids`

Module Output Variables
-----------------------

- vpc_id - A new VPC ID
- security_group_id - A new Security Group ID

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)
