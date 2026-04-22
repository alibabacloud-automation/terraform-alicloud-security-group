
#################
# Security group
#################
variable "create" {
  description = "Whether to create security group. If false, you can specify an existing security group by setting `existing_group_id`."
  type        = bool
  default     = true
}

variable "existing_group_id" {
  description = "ID of existing security group. It will be ignored when create = true."
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of security group. It is used to create a new security group. A random name prefixed with 'terraform-sg-' will be set if it is empty."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = ""
}

variable "security_group_type" {
  description = "The type of the security group. Valid values: 'normal'(basic security group.), 'enterprise'(advanced security group For more information.). Default to 'normal'."
  type        = string
  default     = "normal"
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}
variable "resource_group_id" {
  description = "Id of Resource group"
  type        = string
  default     = null
}


##########
# Security group rules
##########
variable "create_rules" {
  description = "Whether to create ingress and egress rules"
  type        = bool
  default     = true
}

##########
# Ingress
##########
variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on ingress cidrs rules."
  type        = list(string)
  default     = []
}

variable "priority_for_ingress_rules" {
  description = "A priority is used when setting `ingress_rules`. Default to `default_ingress_priority`."
  type        = number
  default     = 1
}

variable "default_ingress_priority" {
  description = "A default ingress priority."
  type        = number
  default     = 50
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used. The valid keys contains `cidr_blocks`, `from_port`, `to_port`, `protocol`, `description`, `priority` and `rule`."
  type        = list(map(string))
  default     = []
}

variable "ingress_with_cidr_blocks_and_ports" {
  description = "List of ingress rules to create where `cidr_blocks` and `ports` is used. The valid keys contains `cidr_blocks`, `ports`, `protocol`, `description` and `priority`. The ports item's `from` and `to` have the same port. Example: '80,443' means 80/80 and 443/443."
  type        = list(map(string))
  default     = []
}

variable "ingress_ports" {
  description = "The port list used on `ingress_with_cidr_blocks_and_ports` ports rules."
  type        = list(number)
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where `source_security_group_id` is used"
  type        = list(map(string))
  default     = []
}

#########
# Egress
#########
variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on egress cidrs rules."
  type        = list(string)
  default     = []
}

variable "priority_for_egress_rules" {
  description = "A priority where `egress_rules` is used. Default to `default_egress_priority`."
  type        = number
  default     = 1
}

variable "default_egress_priority" {
  description = "A default egress priority."
  type        = number
  default     = 50
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used. The valid keys contains `cidr_blocks`, `from_port`, `to_port`, `protocol`, `description` and `priority`."
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks_and_ports" {
  description = "List of egress rules to create where `cidr_blocks` and `ports` is used. The valid keys contains `cidr_blocks`, `ports`, `protocol`, `description` and `priority`. The ports item's `from` and `to` have the same port. Example: '80,443' means 80/80 and 443/443."
  type        = list(map(string))
  default     = []
}

variable "egress_ports" {
  description = "The port list used on `egress_with_cidr_blocks_and_ports` ports rules."
  type        = list(number)
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

# Deprecated variables
variable "this_module_name" {
  description = "(Deprecated) It has been deprecated from 2.0.0, and use `name` instead."
  type        = string
  default     = ""
}

variable "group_name" {
  description = "(Deprecated) It has been deprecated from 2.0.0 and use 'name' instead."
  type        = string
  default     = ""
}

variable "group_description" {
  description = "(Deprecated) It has been deprecated from 2.0.0 and use 'name' instead."
  type        = string
  default     = ""
}

variable "ingress_with_cidr_block" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_with_cidr_blocks` instead. List of ingress rules to create where `cidr_block` is used. Each item's `cidr_block` can not be empty.  If some one item want to use `cidr_blocks`, the first one of `cidr_blocks` will be used."
  type        = list(map(string))
  default     = []
}

variable "ingress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_ports` instead. The port list to use on all ingress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}

variable "protocol_for_ingress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_with_cidr_blocks_and_ports` instead. The default protocol where `ingress_with_ports` is used"
  type        = string
  default     = "tcp"
}

variable "priority_for_ingress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `ingress_with_cidr_blocks_and_ports` instead. A priority is used when setting `ingress_with_ports`. Default to `default_ingress_priority`."
  type        = number
  default     = 1
}

variable "egress_with_cidr_block" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_with_cidr_blocks` instead. List of egress rules to create where `cidr_block` is used. Each item's `cidr_block` can not be empty. If some one item want to use `cidr_blocks`, the first one of `cidr_blocks` will be used."
  type        = list(map(string))
  default     = []
}

variable "egress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_ports` instead. The port list to use on all egress ports rules. `from` and `to` have the same port. Example: [80, 443] means 80/80 and 443/443."
  type        = list(number)
  default     = []
}

variable "protocol_for_egress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_with_cidr_blocks_and_ports` instead. A protocol where `egress_with_ports` is used."
  type        = string
  default     = "tcp"
}

variable "priority_for_egress_with_ports" {
  description = "(Deprecated) It has been deprecated from 2.1.0 and `egress_with_cidr_blocks_and_ports` instead. A priority is used when setting `egress_with_ports`. Default to `default_egress_priority`."
  type        = number
  default     = 1
}


variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  # Protocols (tcp, udp, icmp, all - are allowed keywords) or numbers (from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml):
  default = {
    # Carbon relay
    carbon-line-in-tcp = [2003, 2003, "tcp", "Carbon line-in"]
    carbon-line-in-udp = [2003, 2003, "udp", "Carbon line-in"]
    carbon-pickle-tcp  = [2013, 2013, "tcp", "Carbon pickle"]
    carbon-pickle-udp  = [2013, 2013, "udp", "Carbon pickle"]
    carbon-admin-tcp   = [2004, 2004, "tcp", "Carbon admin"]
    carbon-gui-udp     = [8081, 8081, "tcp", "Carbon GUI"]
    # Cassandra
    cassandra-clients-tcp        = [9042, 9042, "tcp", "Cassandra clients"]
    cassandra-thrift-clients-tcp = [9160, 9160, "tcp", "Cassandra Thrift clients"]
    cassandra-jmx-tcp            = [7199, 7199, "tcp", "JMX"]
    # Consul
    consul-tcp          = [8300, 8300, "tcp", "Consul server"]
    consul-cli-rpc-tcp  = [8400, 8400, "tcp", "Consul CLI RPC"]
    consul-webui-tcp    = [8500, 8500, "tcp", "Consul web UI"]
    consul-dns-tcp      = [8600, 8600, "tcp", "Consul DNS"]
    consul-dns-udp      = [8600, 8600, "udp", "Consul DNS"]
    consul-serf-lan-tcp = [8301, 8301, "tcp", "Serf LAN"]
    consul-serf-lan-udp = [8301, 8301, "udp", "Serf LAN"]
    consul-serf-wan-tcp = [8302, 8302, "tcp", "Serf WAN"]
    consul-serf-wan-udp = [8302, 8302, "udp", "Serf WAN"]
    # DNS
    dns-udp = [53, 53, "udp", "DNS"]
    dns-tcp = [53, 53, "tcp", "DNS"]
    # NTP - Network Time Protocol
    ntp-udp = [123, 123, "udp", "NTP"]
    # Elasticsearch
    elasticsearch-rest-tcp = [9200, 9200, "tcp", "Elasticsearch REST interface"]
    elasticsearch-java-tcp = [9300, 9300, "tcp", "Elasticsearch Java interface"]
    # HTTP
    http-80-tcp   = [80, 80, "tcp", "HTTP"]
    http-8080-tcp = [8080, 8080, "tcp", "HTTP"]
    # HTTPS
    https-443-tcp  = [443, 443, "tcp", "HTTPS"]
    https-8443-tcp = [8443, 8443, "tcp", "HTTPS"]
    # IPSEC
    ipsec-500-udp  = [500, 500, "udp", "IPSEC ISAKMP"]
    ipsec-4500-udp = [4500, 4500, "udp", "IPSEC NAT-T"]
    # Kafka
    kafka-broker-tcp = [9092, 9092, "tcp", "Kafka broker 0.8.2+"]
    # LDAPS
    ldaps-tcp = [636, 636, "tcp", "LDAPS"]
    # Memcached
    memcached-tcp = [11211, 11211, "tcp", "Memcached"]
    # MongoDB
    mongodb-27017-tcp = [27017, 27017, "tcp", "MongoDB"]
    mongodb-27018-tcp = [27018, 27018, "tcp", "MongoDB shard"]
    mongodb-27019-tcp = [27019, 27019, "tcp", "MongoDB config server"]
    # MySQL
    mysql-tcp = [3306, 3306, "tcp", "MySQL"]
    # MSSQL Server
    mssql-tcp           = [1433, 1433, "tcp", "MSSQL Server"]
    mssql-udp           = [1434, 1434, "udp", "MSSQL Browser"]
    mssql-analytics-tcp = [2383, 2383, "tcp", "MSSQL Analytics"]
    mssql-broker-tcp    = [4022, 4022, "tcp", "MSSQL Broker"]
    # NFS/EFS
    nfs-tcp = [2049, 2049, "tcp", "NFS/EFS"]
    # Nomad
    nomad-http-tcp = [4646, 4646, "tcp", "Nomad HTTP"]
    nomad-rpc-tcp  = [4647, 4647, "tcp", "Nomad RPC"]
    nomad-serf-tcp = [4648, 4648, "tcp", "Serf"]
    nomad-serf-udp = [4648, 4648, "udp", "Serf"]
    # OpenVPN
    openvpn-udp       = [1194, 1194, "udp", "OpenVPN"]
    openvpn-tcp       = [943, 943, "tcp", "OpenVPN"]
    openvpn-https-tcp = [443, 443, "tcp", "OpenVPN"]
    # PostgreSQL
    postgresql-tcp = [5432, 5432, "tcp", "PostgreSQL"]
    # Oracle Database
    oracle-db-tcp = [1521, 1521, "tcp", "Oracle"]
    # Puppet
    puppet-tcp   = [8140, 8140, "tcp", "Puppet"]
    puppetdb-tcp = [8081, 8081, "tcp", "PuppetDB"]
    # RabbitMQ
    rabbitmq-4369-tcp  = [4369, 4369, "tcp", "RabbitMQ epmd"]
    rabbitmq-5671-tcp  = [5671, 5671, "tcp", "RabbitMQ"]
    rabbitmq-5672-tcp  = [5672, 5672, "tcp", "RabbitMQ"]
    rabbitmq-15672-tcp = [15672, 15672, "tcp", "RabbitMQ"]
    rabbitmq-25672-tcp = [25672, 25672, "tcp", "RabbitMQ"]
    # RDP
    rdp-tcp = [3389, 3389, "tcp", "Remote Desktop"]
    rdp-udp = [3389, 3389, "udp", "Remote Desktop"]
    # Redis
    redis-tcp = [6379, 6379, "tcp", "Redis"]
    # Redshift
    redshift-tcp = [5439, 5439, "tcp", "Redshift"]
    # Splunk
    splunk-indexer-tcp = [9997, 9997, "tcp", "Splunk indexer"]
    splunk-web-tcp     = [8000, 8000, "tcp", "Splunk Web"]
    splunk-splunkd-tcp = [8089, 8089, "tcp", "Splunkd"]
    splunk-hec-tcp     = [8088, 8088, "tcp", "Splunk HEC"]
    # Squid
    squid-proxy-tcp = [3128, 3128, "tcp", "Squid default proxy"]
    # SSH
    ssh-tcp = [22, 22, "tcp", "SSH"]
    # Storm
    storm-nimbus-tcp     = [6627, 6627, "tcp", "Nimbus"]
    storm-ui-tcp         = [8080, 8080, "tcp", "Storm UI"]
    storm-supervisor-tcp = [6700, 6703, "tcp", "Supervisor"]
    # Web
    web-jmx-tcp = [1099, 1099, "tcp", "JMX"]
    # WinRM
    winrm-http-tcp  = [5985, 5985, "tcp", "WinRM HTTP"]
    winrm-https-tcp = [5986, 5986, "tcp", "WinRM HTTPS"]
    # Zipkin
    zipkin-admin-tcp       = [9990, 9990, "tcp", "Zipkin Admin port collector"]
    zipkin-admin-query-tcp = [9901, 9901, "tcp", "Zipkin Admin port query"]
    zipkin-admin-web-tcp   = [9991, 9991, "tcp", "Zipkin Admin port web"]
    zipkin-query-tcp       = [9411, 9411, "tcp", "Zipkin query port"]
    zipkin-web-tcp         = [8080, 8080, "tcp", "Zipkin web port"]
    # Zookeeper
    zookeeper-2181-tcp = [2181, 2181, "tcp", "Zookeeper"]
    zookeeper-2888-tcp = [2888, 2888, "tcp", "Zookeeper"]
    zookeeper-3888-tcp = [3888, 3888, "tcp", "Zookeeper"]
    zookeeper-jmx-tcp  = [7199, 7199, "tcp", "JMX"]
    # Open all ports & protocols
    all-all  = [-1, -1, "all", "All protocols"]
    all-tcp  = [0, 65535, "tcp", "All TCP ports"]
    all-udp  = [0, 65535, "udp", "All UDP ports"]
    all-icmp = [-1, -1, "icmp", "All IPV4 ICMP"]
    # This is a fallback rule to pass to lookup() as default. It does not open anything, because it should never be used.
    _ = ["", "", ""]
  }
}

