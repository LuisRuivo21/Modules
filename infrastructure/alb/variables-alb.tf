# Project naming variable
#---------------------------------------
variable "project_name" {
  description = "Project name."
  type        = string
  default     = "luis-cloud-app"
}


# ALB variables
#----------------------------------------
variable "load_balancer_internal" {
  description = "Is load balancer internal facing?"
  type        = bool
  default     = false
}

variable "load_balancer_type" {
  description = "Load balancer type."
  type        = string
  default     = "application"
}


# ALB Listener variables
#----------------------------------------
variable "alb_listener_http" {
  description = "Http ALB Listener."
  type        = map(any)
  default = {
    "port"        = 80
    "protocol"    = "HTTP"
    "action_type" = "forward"
  }
}

# variable "alb_listener_https" {
#   description = "Https ALB Listener."
#   type        = map(any)
#   default = {
#     "port"        = 443
#     "protocol"    = "HTTPS"
#     "action_type" = "forward"
#   }
# }


# ALB Target Group variables
#----------------------------------------
variable "alb_tg_http" {
  description = "http target group vars"
  type        = map(any)
  default = {
    "port"     = 80
    "protocol" = "HTTP"

  }
}

variable "alb_tg_https" {
  type        = map(any)
  description = "https target group vars"
  default = {
    "port"     = 443
    "protocol" = "HTTPS"

  }
}



# MODULES OUTPUTS VARIABLES
# ------------------------------------

# Security Group Module outputs
# ------------------------------------
variable "ec2_sg_id" {
  description = "This variable is getting the output from the Security Group Module."
  type        = string # this can't be a set of string...
}


# Network Module outputs
# ------------------------------------
variable "vpc_id" {
  description = "value"
  type        = string # this can't be a set(string)
}

variable "public_subnets" {
  description = "This variable is getting the output from the Network Module."
  type        = set(string) # is this a set(string) or string?
}
