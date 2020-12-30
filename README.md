# Terraform: Apache2 with AutoScale Group

This Project is used for the creation of EC2 instances under Load Balancer (ELB) each instance have Apache2 (installed by bootstrapping) and with connections at S3 by IAM role, these instances are attached to AutoScaleGroup and it uses CPU metrics to resize the environment:
```
Scale up   - CPU > 80%
Scale down - CPU < 60%
```

This project are segmented through 2 modules:

**ec2-lb** 

Responsible to create all resources of network, permissions, load balancer, and instance.

**asg**

This module is used to create Auto Scale Group, attach the instance from ec2-lb to ASG and all requisites to make the cluster grow up and down.

## Requisites

- Valid *AWS Account*

-  [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) - To manage AWS resources at the command line, ASG's module use aws-cli to attach existing EC2 to ASG

- Credentials configured

```
export AWS_ACCESS_KEY_ID=""
export AWS_SECRET_ACCESS_KEY=""
export AWS_DEFAULT_REGION=""
```
or
```
aws configure
```

- Terraform 13.5 installed or use [tfenv](https://github.com/tfutils/tfenv) - to manage terraform version's.


### Install Terraform correctly version with TFenv
If you dont have tfenv but terraform `13.5` is installed at your system skip this step.
```
tfenv install
```
> For this step works the file .terraform-version is required at the current path.


## Executing the project

To custom that project you can modify [variables.tf](https://github.com/leonardomoraesmendes/apache-autoscale/blob/master/variables.tf), at the variables file you can alter:
```
name          = Default name, this name are used to define resources name inside the modules.
region        = Region of AWS where all resources will be deployed.
instance_type = Instance type/Flavor.
create_asg    = Used for deciding to create or not the Auto Scaling Group, if false this project only create EC2 with ELB and if true created ASG and all resources to scale up and down the environment.
```

After that just execute:
```
terraform init
terraform plan
terraform apply
```

## Testing the webserver
Get the URL of LoadBalance
```
terraform output  
```
Open in browser:

http://<elb_id>.<region>.elb.amazonaws.com/

http://<elb_id>.<region>.elb.amazonaws.com/s3.html

## Testing the Auto Scale Group
If you apply ASG you can test to grow up the cluster using a simple tool like ApacheBenchmark `ab`, but to scale up you need to execute that many times, since apache's process is very light

Get the URL of LoadBalance:
```
terraform output  
```
Running benchmark
```
ab -n 10000 -c 50 http://<elb_id>.<region>.elb.amazonaws.com/
```