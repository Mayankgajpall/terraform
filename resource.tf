resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name = "kproject-vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "ap-south-1b"

  tags = {
    Name = "kproject-subnet"
  }
}

resource "aws_internet_gateway" "my_ig" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "kproject-ig"
  }
}

resource "aws_security_group_rule" "allow_all" {
  type              = "ingress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.my_vpc.default_security_group_id
}

resource "aws_route" "my-route" {
  route_table_id            = aws_vpc.my_vpc.default_route_table_id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.my_ig.id
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "master" {
  count                       = var.number_of_master_node
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.master_instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = ["${aws_vpc.my_vpc.default_security_group_id}"]
  tags = {
    "Name" = "kmaster-n0${count.index+1}"
  }
}

resource "aws_instance" "worker" {
  count                       = var.number_of_worker_node
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.worker_instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.my_subnet.id
  vpc_security_group_ids      = ["${aws_vpc.my_vpc.default_security_group_id}"]
  tags = {
    "Name" = "kworker-n0${count.index+1}"
  }
}