### Variables
variable db_storage {
  default = "20"
}

variable db_engine {
  default = "mariadb"
}

variable db_instance_type {
  default = "db.t2.micro"
}

variable db_user {
  default = "duoquadra"
}

variable db_password {
  default = "crimson42"
}

variable db_name {
  default = "training42"
}

# The name of the database is already in the snapshot
variable db_snapshot {
  default = "arn:aws:rds:eu-west-1:159571505100:snapshot:attendeelist"
}

### Resources
resource "aws_db_subnet_group" "mariadb" {
  name = "rds_subnet_group"
  subnet_ids = ["${aws_subnet.private.*.id}"]
  tags {
    Name = "rds subnet group"
  }
  # see https://www.terraform.io/docs/providers/aws/r/db_subnet_group.html
}

resource "aws_db_instance" "mariadb" {
  allocated_storage = "${var.db_storage}"
  engine = "${var.db_engine}"
  instance_class = "${var.db_instance_type}"
  name = "${var.db_name}"
  username = "${var.db_user}"
  password = "${var.db_password}"
  db_subnet_group_name = "${aws_db_subnet_group.mariadb.id}"
  # see https://www.terraform.io/docs/providers/aws/r/db_instance.html
  # create the db from the given snapshot
}

### Outputs
output "mariadb_host" {
  value = "${aws_db_instance.mariadb.endpoint}"
  # see https://www.terraform.io/intro/getting-started/outputs.html
}

output "mariadb_db" {
  value = "${var.db_name}"
}

output "mariadb_user" {
  value = "${var.db_user}"
}

output "mariadb_password" {
  value = "${var.db_password}"
}
