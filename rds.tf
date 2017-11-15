resource "aws_db_instance" "tsalisbury_umg_rds" {
  allocated_storage       = 10
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "5.6.37"
  instance_class          = "${var.rds_instance_type}"
  identifier              = "${var.rds_instance_identifier}"
  username                = "${var.rds_instance_username}"
  password                = "${var.rds_instance_password}"
  parameter_group_name    = "default.mysql5.6"
  vpc_security_group_ids  = ["${aws_security_group.tsalisbury_umg_rds_sg.id}"]
  skip_final_snapshot     = "true"
}

output "tsalisbury_rds_connection_endpoint" {
  value = "${aws_db_instance.tsalisbury_umg_rds.endpoint}"
}
