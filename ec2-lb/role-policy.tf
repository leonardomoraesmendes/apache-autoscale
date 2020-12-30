resource "aws_iam_role" "ec2_access_role" {
  name               = "${var.name}-role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ec2.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF 
}

data "aws_iam_policy" "s3" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "attach-s3" {
  role       =  aws_iam_role.ec2_access_role.name
  policy_arn =  data.aws_iam_policy.s3.arn
}

resource "aws_iam_instance_profile" "apache_profile" {
  name  = "${var.name}-profile"
  role = aws_iam_role.ec2_access_role.name
}