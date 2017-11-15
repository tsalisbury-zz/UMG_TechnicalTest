resource "aws_launch_configuration" "tsalisbury_umg_launchconfig" {
  name                 = "tsalisbury_umg_launchconfig"
  key_name             = "${aws_key_pair.tsalisbury_umg_key.key_name}"
  image_id             = "${var.ami_id}"
  instance_type        = "${var.ec2_instance_type}"
  security_groups      = ["${aws_security_group.tsalisbury_umg_ec2_sg.id}"]
  user_data            = "#!/bin/bash\nsudo yum update -y && sudo yum install -y docker && sudo service docker start && sudo usermod -a -G docker ec2-user && sudo yum -y install mysql"
}

resource "aws_autoscaling_group" "tsalisbury_umg_asg" {
  name                 = "tsalisbury_umg_asg"
  availability_zones   = ["${split(",", var.availability_zones)}"]
  launch_configuration = "${aws_launch_configuration.tsalisbury_umg_launchconfig.name}"
  min_size             = 1
  max_size             = 1
  desired_capacity     = 1
}

resource "aws_key_pair" "tsalisbury_umg_key" {
  key_name   = "tsalisbury_umg_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCoHX3udLRa10TK93wCOYwjdhMfKVNphpJOe0vnY0sRu++JxomSfQbCvDIArAgIcsJZD25L+bwRWyqDEVDr+HEiB9sD2ImgCe+luen99P6n809QcA4gR63nwkprtmJlMFQ8BUrHrOTJ9vuxTv1K9WmYl5Fedn1RaT2aCh886pF/zrWqXroA5lWDhTo/HEM+QsxekUMXX5EHG9hBotXT0QU6EhpKQ0wRocXcG6AJGhysrLikyaL2NVbHstPhPb0Dput+68Tml7hB0awe8UKI7RoSemh+bjlnt5PDSv4HhEzjjI3hXpxXR+CJ97pLCp+GAZYvUL4yyz0AMt907SHBVXOX tom@toms-mbp.mynet"
}
