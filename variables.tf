variable name {
  type        = string
  default     = "MyApache"
  description = "Default name, this name are used to define resources name"
}

variable region {
  type        = string
  default     = "us-east-1"
  description = "Region of AWS where all resources will be deployed"
}

variable instance_type {
  type        = string
  default     = "t3.micro"
  description = "Instance type/Flavor"
}

variable create_asg {
  type        = bool
  default     = true
  description = "Used for decide to create or not the Auto Scaling Group with their resources"
}
