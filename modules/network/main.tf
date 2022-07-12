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