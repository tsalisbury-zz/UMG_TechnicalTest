variable "region" {
  default = "eu-west-1"
}

variable "ami_id" {
  default = "ami-760aaa0f"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "rds_instance_type" {
  default = "db.t2.micro"
}

variable "rds_instance_identifier" {
  default = "tsalisbury-umg-rds"
}

variable "rds_instance_username" {
  default = "umg"
}

variable "rds_instance_password" {
  default = "tomsalisbury"
}

variable "ec2_security_group" {
  default = "tsalisbury_umg_ec2_sg"
}

variable "rds_security_group" {
  default = "tsalisbury_umg_rds_sg"
}

variable "availability_zones" {
  description = "The availability zones"
  default = "eu-west-1a,eu-west-1b,eu-west-1c"
}
