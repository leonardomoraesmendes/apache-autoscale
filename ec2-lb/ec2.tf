data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    owners = ["099720109477"]
}

resource "aws_instance" "apache" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  user_data              = templatefile("${path.module}/provision/bootstrap.sh", { s3_bucket_name = aws_s3_bucket.S3.id })
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.SG.id]
  iam_instance_profile   = aws_iam_instance_profile.apache_profile.name
  
  tags = {
    Name = "EC2-${var.name}"
  }

  depends_on = [aws_nat_gateway.NAT, aws_s3_bucket.S3]

}