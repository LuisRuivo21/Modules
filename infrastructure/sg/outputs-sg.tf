# SSH Security Group output
#----------------------------------------
output "ssh_sg_id" {
  description = "SSH Security Group id."
  value       = aws_security_group.ssh_sg.id
}


# EC2 Security Group output
#----------------------------------------
output "ec2_sg_id" {
  description = "EC2 Security Group id."
  value       = aws_security_group.ec2_sg.id
}


# ALB Security Group output
#----------------------------------------
output "alb_sg_id" {
  description = "ALB Security Group id."
  value       = aws_security_group.alb_sg.id
}


# SSH and ALB Security Group output
#----------------------------------------
output "ssh_alb_sg_ids" {
  description = "SSH and ALB Security Group ids."
  value       = [aws_security_group.ssh_sg.id, aws_security_group.alb_sg.id]
}
