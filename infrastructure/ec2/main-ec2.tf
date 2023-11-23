# EC2 LAUNCH TEMPLATE
#----------------------------------------
resource "aws_launch_template" "ec2" {
  name                   = "${var.project_name}-ec2"
  image_id               = var.ec2_ami
  instance_type          = var.ec2_type
  user_data              = filebase64("${path.module}/${var.user_data_file}")
  key_name               = var.key_pair
  vpc_security_group_ids = var.ssh_alb_sg_ids

  tags = {
    "Name" = "${var.project_name}-ec2"
  }
}
