# ALB Target Group output
#----------------------------------------
output "alb_tg_http_arn" {
  description = "ALB Target Group http ARN (Amazon Resource Name)."
  value       = aws_lb_target_group.alb_tg_http.arn
}



# ALB DNS Hostname
#----------------------------------------
output "alb_dns" {
  description = "ALB public DNS."
  value       = "http://${aws_lb.alb.dns_name}"
}
