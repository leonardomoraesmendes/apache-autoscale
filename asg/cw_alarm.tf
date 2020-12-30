resource "aws_cloudwatch_metric_alarm" "UP" {
  alarm_name = "${var.name}-alarm-UP"
  alarm_description = "Alarm to expose high uses of CPU, and executes policy to scale-up the ASG"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG.name
  }

  alarm_actions = [aws_autoscaling_policy.scale-up.arn]
}

resource "aws_cloudwatch_metric_alarm" "DOWN" {
  alarm_name = "${var.name}-alarm-DOWN"
  alarm_description = "Alarm to expose low uses of CPU, and executes policy to scale-down the ASG"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG.name
  }
  alarm_actions = [aws_autoscaling_policy.scale-down.arn]
}