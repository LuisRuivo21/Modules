# VPC output
#----------------------------------------
output "vpc_id" {
  description = "VPC id."
  value       = aws_vpc.vpc.id
}


# Public Subnets output
#----------------------------------------
output "public_subnets" {
  description = "Public Subnets Resource."
  value       = aws_subnet.public_subnets
}


# Private Subnets output
#----------------------------------------
output "private_subnets" {
  description = "Private Subnets Resource."
  value       = aws_subnet.private_subnets
}
