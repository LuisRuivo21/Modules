# ALB
#----------------------------------------
resource "aws_lb" "alb" {
  name               = "${var.project_name}-alb"
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.ec2_sg_id]            # check this again if error
  subnets            = tolist(var.public_subnets) # check this again if error

  tags = {
    Name = "${var.project_name}-alb"
  }
}


# ALB LISTENERS
#----------------------------------------

# ALB http Listener
#----------------------------------------
resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_http["port"]
  protocol          = var.alb_listener_http["protocol"]

  default_action {
    type             = var.alb_listener_http["action_type"]
    target_group_arn = aws_lb_target_group.alb_tg_http.arn
  }
}

# ALB https Listener
#----------------------------------------
# resource "aws_lb_listener" "alb_listener_https" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = var.alb_listener_https["port"]
#   protocol          = var.alb_listener_https["protocol"]

#   default_action {
#     type             = var.alb_listener_http["action_type"]
#     target_group_arn = aws_lb_target_group.alb_tg_https.arn
#   }
# }


# ALB TARGET GROUPS 
#----------------------------------------

# ALB http Target Group
#----------------------------------------
resource "aws_lb_target_group" "alb_tg_http" {
  name       = "${var.project_name}-alb-tg-http"
  depends_on = [aws_lb.alb]
  port       = var.alb_tg_http["port"]
  protocol   = var.alb_tg_http["protocol"]
  vpc_id     = var.vpc_id
}

# ALB https Target Group
#----------------------------------------
# resource "aws_lb_target_group" "web_alb_tg_https" {
#   name       = "${var.app_name}--alb-tg-https"
#   depends_on = [aws_lb.alb]
#   port       = var.alb_tg_https["port"]
#   protocol   = var.alb_tg_https["protocol"]
#   vpc_id     = var.vpc_id
# }

