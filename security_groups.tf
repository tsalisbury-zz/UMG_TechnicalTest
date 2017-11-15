resource "aws_security_group" "tsalisbury_umg_ec2_sg" {
  name = "${var.ec2_security_group}"
  description = "EC2 Instance Allowed Ports"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "tsalisbury_umg_rds_sg" {
  name = "${var.rds_security_group}"
  description = "EC2 Instance Allowed Ports"

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = ["${aws_security_group.tsalisbury_umg_ec2_sg.id}"]
  }

}
