# Project naming variable
#---------------------------------------
variable "project_name" {
  description = "Project name."
  type        = string
  default     = "luis-cloud-app"
}


# VPC variables
#----------------------------------------
variable "vpc_cidr" {
  description = "VPC cidr block."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Enable dns hostnames."
  type        = bool
  default     = true
}


# SUBNETS variables
#----------------------------------------

# Public subnet variables
#----------------------------------------
variable "public_subnets" {
  description = "Public subnets."
  default = {
    "public-subnet-1" = 0
    "public-subnet-2" = 1
  }
}

variable "map_public_ip_on_launch" {
  description = "Enable auto-assign ipv4."
  type        = bool
  default     = true
}

# Private Subnets variable
#----------------------------------------
variable "private_subnets" {
  description = "Private subnets."
  default = {
    "private-subnet-1" = 0
    "private-subnet-2" = 1
  }
}

# Route Tables variable
#---------------------------------------
variable "all_traffic" {
  description = "Allow all traffic."
  type        = string
  default     = "0.0.0.0/0"
}
