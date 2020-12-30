#!/bin/bash -x
apt update -y
apt install apache2 awscli -y
systemctl start apache2
systemctl enable apache2
sed -i "1s,^,\<h1\>WebServer\: $(hostname)\<\/h1\> ," /var/www/html/index.html
aws s3 cp s3://${s3_bucket_name}/s3.html /var/www/html/