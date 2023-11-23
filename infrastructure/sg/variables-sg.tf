# Project naming variable
#---------------------------------------
variable "project_name" {
  description = "Project name."
  type        = string
  default     = "luis-cloud-app"
}


# Security Group variables
#----------------------------------------
variable "ssh_sg" {
  description = "SSH Security Group variable."
  type        = map(any)
  default = {
    "cidr_block"     = "0.0.0.0/0" # For testing purpose we will open all traffic but this must be restricted to your own IP address (x.x.x.x/32).
    "timeout_delete" = "2m"
  }
}

variable "ec2_sg" {
  description = "EC2 Security Group variable."
  type        = map(any)
  default = {
    "timeout_delete" = "2m"
  }
}

variable "alb_sg" {
  description = "ALB Security Group variable."
  type        = map(any)
  default = {
    "timeout_delete" = "2m"
  }
}

variable "all_traffic" {
  description = "Allow all traffic."
  type        = string
  default     = "0.0.0.0/0"
}



# MODULES OUTPUTS VARIABLES
# ------------------------------------

# Network Module outputs
# ------------------------------------
variable "vpc_id" {
  description = "This variable is getting the output from the Security Group Module."
  type        = string
}

