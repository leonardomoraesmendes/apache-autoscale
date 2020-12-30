output elb_dns {
  value = aws_elb.ELB.dns_name
}
output elb_id {
  value = aws_elb.ELB.id
}
output s3_id {
  value = aws_s3_bucket.S3.id
}
output sg_id {
  value = aws_security_group.SG.id
}
output vpc_id {
  value = aws_vpc.VPC.id
}
output instance_id {
  value = aws_instance.apache.id
}
output bucket_name {
  value       = aws_s3_bucket.S3.id
}
