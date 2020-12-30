resource "aws_launch_configuration" "LC" {
  image_id        = data.aws_ami.ubuntu.id
  instance_type   = var.instance_type
  user_data       = templatefile("${path.module}/provision/bootstrap.sh", { s3_bucket_name = data.aws_s3_bucket.S3.id })
  security_groups = [data.aws_security_group.SG.id]

  lifecycle {
    create_before_destroy = true
  }
}