resource "aws_elb" "ELB" {
  name               = "terraform-elb"
  security_groups    = [aws_security_group.SG.id]
  subnets            = [aws_subnet.public.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
 
  instances = [aws_instance.apache.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "ELB-${var.name}"
  }

}