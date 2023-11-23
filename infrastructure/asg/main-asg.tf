# ASG
#----------------------------------------
resource "aws_autoscaling_group" "asg" {
  name                = "${var.project_name}-asg"
  min_size            = var.asg_capacity["min"]
  max_size            = var.asg_capacity["max"]
  desired_capacity    = var.asg_capacity["desired_capacity"]
  vpc_zone_identifier = tolist(var.private_subnets)
  target_group_arns   = [var.alb_tg_http_arn]
  health_check_type   = var.asg_health_check_type

  launch_template {
    id      = var.ec2_id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-asg"
    propagate_at_launch = true
  }
}


# ASG SCALING POLICY
#----------------------------------------
resource "aws_autoscaling_policy" "asg_scaling_policy" {
  name                   = "${var.project_name}-asg-scaling-policy"
  policy_type            = var.asg_scaling_policy["policy_type"]
  autoscaling_group_name = aws_autoscaling_group.asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.asg_scaling_policy["metric_type"]
    }

    target_value = var.asg_scaling_policy["target_value"]
  }
}
