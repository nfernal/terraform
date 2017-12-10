data "aws_caller_identity" "current" {}

data "aws_ami" "ami" {
  most_recent = true
  owners      = ["${data.aws_caller_identity.current.account_id}"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["packer-centos6.9-base*"]
  }
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ami.id}"
  instance_type = "t2.micro"

  tags {
    Name = "HelloWorld"
  }
}
