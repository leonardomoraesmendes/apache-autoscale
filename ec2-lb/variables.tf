variable name {}
variable instance_type {}
variable region {}

variable vpcCIDRblock {
  type        = string
  default = "100.0.0.0/16"
}

variable private_cidr {
  type        = string
  default     = "100.0.1.0/24"
  description = "CIDR for Private Subnet"
}

variable public_cidr {
  type        = string
  default     = "100.0.2.0/24"
  description = "CIDR for Private Subnet"
}