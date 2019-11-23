variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ami" {}

variable "instance_type" {
  default = "t2.micro"
}

locals {
  label_id = "terraform-${formatdate("YYYY-MM-DD", timestamp())}"
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type

  key_name = aws_key_pair.this.key_name
  security_groups = [
    aws_security_group.allow_ssh.name
  ]

  tag {
    Name = "terraform-quickstart"
  }
}

resource "aws_key_pair" "this" {
  key_name   = local.label_id
  public_key = file(var.ssh_public_key_path)
}

resource "aws_security_group" "allow_ssh" {
  name        = local.label_id
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

output "public_ip" {
  value = aws_instance.this.public_ip
}
