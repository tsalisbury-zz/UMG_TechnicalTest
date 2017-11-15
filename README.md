# UMG_TechnicalTest
This code repository is for creation of an EC2 ASG running docker engine, with an RDS instance and attendant security groups.  All the resources created here are AWS free tier eligible, and all names have been prefixed with my name, so that it is clear which resources have been created.

## Prerequistites
- An AWS account, with credentials set in `~/.aws/credentials`, so that infrastructure may be created from the command line, and a default region of `eu-west-1`.
- This code assumes the existence of the default vpc, ec2 and rds subnets, which are present when a new AWS account is created.  By not specifying a vpc or subnets in this code, the resources are automatically deploying into the defaults.
- Terraform installed.

## Infrastructure Build and Destroy
From the root directory, initialise the terraform environment by running
```
terraform init
```

It's possible to see what resources will be created by running
```
terraform plan
```

To actually build the infrastructure, run
```
terraform apply
```

And to terminated it,
```
terraform destroy
```

## Test
We will want to verify four things.
1. The resources have all been created.
2. We can connect to the EC2 instance.
3. The EC2 instance is the only entity which can connect to the RDS instance.
4. Docker is installed and running on the EC2 instance.

1. The terraform apply should show that six resources have been created:
..* 2 security groups
..* 1 autoscaling launch configuration
..* 1 autoscaling group of instance size 1
..* 1 EC2 keypair
..* 1 RDS instance
All these resources should be easily visible in the AWS console.

2. Using the private ssh key in the directory `ec2-ssh-key`, log into the ec2 instance from the root directory by running
```
ssh -i ec2-ssh-key/tsalisbury_umg_key ec2-user@<ec2-instance-public-dns>
```
where `<ec2-instance-public-dns>` is the public dns address obtained from viewing the instance in the EC2 console.

3. Once logged into the EC2 instance, run
```
mysql -u umg -ptomsalisbury -h <tsalisbury_rds_connection_endpoint>
```
where `<tsalisbury_rds_connection_endpoint>` is obtained from the output of creating the infrastructure using `terraform apply`.

4. Also, when logged into the EC2 instance, run
```
sudo service docker status
```
and
```
docker info
```
These commands should show that the docker service is running, what containers it has, and what resources it is using.

## Extras
There are still some things which would be created slightly differently here, if this was production infrastructure in an enterprise:
- For security, the private ssh key for the EC2 instance would not be added to the repository, even if there was no possibility of data/identity theft as is the case here.  The key would be kept securely by the Operations team.
- The database password would also not be specified in this repo as a variable.  Instead the password would be stored securely by the engineer, and the variable would be left empty and supplied on the CLI at build time.
- It would be simpler to use the latest CoreOS ami, rather than AWS Linux, but obviously that would defeat the object of this test - to show the ability to install the docker engine as part of the instance creation.
- The Terraform state file is not set to be stored remotely.  If many people were working on this infrastructure, it would be necessary to sync the state to an S3 bucket, or other suitable storage.
- Normally, for resilience, it is advisable to run a minimum of two ec2 instances, in case one fails.  This would necessitate creation of an ELB and perhaps tags, cloudwatch metrics and alarms, but these seem beyond the scope of this task and have been left off so as not to complicate things too much.
- It would also normally makes sense to tag all resource for purposes such as billing or identification for things like backup scripts, but that would be beyond the scope of this task and has been left out for maximum simplicity.
