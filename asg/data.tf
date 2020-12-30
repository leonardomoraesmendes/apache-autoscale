data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    owners = ["099720109477"]
}

data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id
 
  tags = {
    Tier = "private"
  }

}

data "aws_vpc" "VPC" {
  id = var.vpc_id
}

data "aws_elb" "ELB" {
  name = var.elb_id
}

data "aws_s3_bucket" "S3" {
  bucket = var.s3_id
}

data "aws_security_group" "SG" {
  id = var.security_group_id
}