# Project naming variable
#---------------------------------------
variable "project_name" {
  description = "Project name."
  type        = string
  default     = "luis-cloud-app"
}


# EC2 variables
#----------------------------------------
variable "ec2_ami" {
  description = "Instance AMI: Amazon Linux 2 for eu-west-2 region."
  type        = string
  default     = "ami-06d0baf788edae448"
}
variable "ec2_type" {
  description = "Instance type."
  type        = string
  default     = "t2.micro"
}

variable "user_data_file" {
  type        = string
  description = "user data file path"
  default     = "install_nginx.sh"
}

variable "key_pair" {
  type        = string
  description = "ec2 key pair"
  default     = "cloud-app-key"
}



# MODULES OUTPUTS VARIABLES
# ------------------------------------

# Security Group Module outputs
# ------------------------------------
variable "ssh_alb_sg_ids" {
  description = "This variable is getting the output from the Security Group Module."
  type        = set(string)
}
