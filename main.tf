module ec2-lb {
  source        = "./ec2-lb"
  name          = var.name
  region        = var.region
  instance_type = var.instance_type
}

module asg {
  count         = var.create_asg == true ? 1 : 0 
  source        = "./asg"
  name          = var.name
  region        = var.region
  instance_type = var.instance_type

  ## Values from module ec2-lb 
  elb_id            = module.ec2-lb.elb_id
  s3_id             = module.ec2-lb.s3_id
  vpc_id            = module.ec2-lb.vpc_id
  security_group_id = module.ec2-lb.sg_id
  instance_id       = module.ec2-lb.instance_id

  depends_on = [module.ec2-lb]

}