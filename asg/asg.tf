resource "aws_autoscaling_group" "ASG" {
  launch_configuration = aws_launch_configuration.LC.name
  min_size             = 1
  max_size             = 3
  enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity  = "1Minute"
  load_balancers       = [data.aws_elb.ELB.id]
  health_check_type    = "ELB"
  vpc_zone_identifier  = data.aws_subnet_ids.private.ids
  tag {
    key                 = "Name"
    value               = "EC2-${var.name}000"
    propagate_at_launch = true
    }
}

resource "aws_autoscaling_policy" "scale-up" {
  name                   = "terraform-scale-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ASG.name
}

resource "aws_autoscaling_policy" "scale-down" {
  name                   = "terraform-scale-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.ASG.name
}

#####
## Attach EC2 from ec2-lb module to ASG
#####

resource "null_resource" "attach-EC2" {
  provisioner "local-exec" {
    on_failure  = fail
    interpreter = ["/bin/bash", "-c"]
    command     = "aws autoscaling attach-instances --instance-ids ${var.instance_id} --auto-scaling-group-name ${aws_autoscaling_group.ASG.id} "
  }
}