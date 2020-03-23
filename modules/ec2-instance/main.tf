variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ami" {
  default = ""
}

variable "instance_type" {
  default = "t2.micro"
}

locals {
  name_prefix = "terraless-"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "this" {
  ami           = coalesce(var.ami, data.aws_ami.ubuntu.id)
  instance_type = var.instance_type

  key_name = aws_key_pair.this.key_name
  security_groups = [
    aws_security_group.allow_ssh.name
  ]
}

resource "aws_key_pair" "this" {
  key_name_prefix   = local.name_prefix
  public_key = file(var.ssh_public_key_path)
}

resource "aws_security_group" "allow_ssh" {
  name_prefix        = local.name_prefix
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
