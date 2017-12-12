# Template for initial configuration bash script
data "template_file" "init" {
  template = "${file("init.tpl")}"

  vars {
    db_host = "${aws_db_instance.mariadb.endpoint}"
  }
}

# Create a web server
resource "aws_instance" "web" {
  ami = "${var.front_ami}"
  instance_type = "t2.micro"
  user_data = "${data.template_file.init.rendered}"
}
