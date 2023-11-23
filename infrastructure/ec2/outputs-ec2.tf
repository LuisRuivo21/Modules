# EC2 Launch Template Output
#----------------------------------------
output "ec2_id" {
  description = "EC2 id."
  value       = aws_launch_template.ec2.id
}
