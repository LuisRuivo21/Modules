# Project naming variable
#---------------------------------------
variable "project_name" {
  description = "Project name."
  type        = string
  default     = "luis-cloud-app"
}


# ASG variables
#----------------------------------------
variable "asg_capacity" {
  description = "The min, max, and desired instance capacity."
  type        = map(any)
  default = {
    "min"              = 2
    "max"              = 5
    "desired_capacity" = 2
  }
}
variable "asg_health_check_type" {
  description = "Health check type."
  type        = string
  default     = "ELB"
}

variable "asg_scaling_policy" {
  description = "ASG Scaling policy."
  type        = map(any)
  default = {
    "policy_type"  = "TargetTrackingScaling"
    "metric_type"  = "ASGAverageCPUUtilization"
    "target_value" = 75.0
  }
}

variable "enable_asg" {
  default = true
}



# MODULES OUTPUTS VARIABLES
# ------------------------------------

# Network Module outputs
# ------------------------------------
variable "private_subnets" {
  description = "This variable is getting the output from the Network Module."
  type        = set(string) # is this a set(string) or string?
}


# ALB Module outputs
# ------------------------------------
variable "alb_tg_http_arn" {
  description = "This variable is getting the output from the ALB Module."
  type        = string # this can't be a set(string)
}


# Security Group Module outputs
# ------------------------------------
variable "ssh_sg_id" {
  description = "This variable is getting the output from the Security Group Module."
  type        = set(string)
}

variable "alb_sg_id" {
  description = "This variable is getting the output from the Security Group Module."
  type        = set(string)
}


# EC2 Module outputs
# ------------------------------------
variable "ec2_id" {
  description = "This variable is getting the output from the EC2 Module."
  type        = string
}
