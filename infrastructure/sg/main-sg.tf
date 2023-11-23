# SSH SECURITY GROUP
#----------------------------------------------------
resource "aws_security_group" "ssh_sg" {
  name        = "${var.project_name}-ssh-sg"
  description = "Allow SSH to EC2 instances."
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from IP."
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_sg["cidr_block"]]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.ssh_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.project_name}-ssh-sg"
  }
}


# EC2 SECURITY GROUP
#----------------------------------------------------
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-ec2-sg"
  description = "Allow http & https traffic from internet to ALB."
  vpc_id      = var.vpc_id

  # Inbound http traffic
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  # Inbound https traffic
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }

  # Outbound traffic
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_traffic]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.ec2_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.project_name}-ec2-sg"
  }
}


# ALB SECURITY GROUP
#----------------------------------------------------
resource "aws_security_group" "alb_sg" {
  name        = "${var.project_name}-alb-sg"
  description = "Allow http & https traffic from the ALB to ASG EC2 instances."
  vpc_id      = var.vpc_id

  # Inbound http traffic
  ingress {
    description     = "Allow http traffic from internet to ALB Security Group."
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  # Inbound https traffic
  ingress {
    description     = "Allow https traffic from internet to ALB Security Group."
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  # Outbound traffic
  egress {
    description      = "Allow outside internet access to all traffic."
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_traffic]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    delete = var.alb_sg["timeout_delete"]
  }

  tags = {
    Name = "${var.project_name}-alb-access-sg"
  }
}
