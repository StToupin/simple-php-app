### Variables
variable front_instance_number {
  default = "2"
}

variable front_ami {
  default = "ami-82f4dae7" # Ubuntu 16.04
}

variable front_instance_type {
  default = "t2.micro"
}

variable front_elb_port {
  default = "8080"
}

variable front_elb_protocol {
  default = "http"
}

resource "aws_instance" "front" {
  ami = "${var.front_ami}"
  instance_type = "${var.front_instance_type}"
  subnet_id = "${aws_subnet.public.0.id}"
  key_name = "AKIAJATNRXHCWY5QQSRQ"
  # see https://www.terraform.io/docs/providers/aws/r/instance.html
}

resource "aws_elb" "front" {
  name = "formation42-teraform-elb"
  #availability_zones = ["${var.azs}"] # from vpc.tf
  instances = ["${aws_instance.front.*.id}"]
  subnets = ["${aws_subnet.public.*.id}"]
  #cross_zone_load_balancing = true
  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 8080
    lb_protocol       = "http"
  }
  # see https://www.terraform.io/docs/providers/aws/r/elb.html
}

### Outputs
output "elb_endpoint" {
  value = "${aws_elb.front.dns_name}"
  # see https://www.terraform.io/intro/getting-started/outputs.html
}

output "instance_ip" {
  value = "${aws_instance.front.public_ip}"
}
