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
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = ["${var.vpc_security_group_id}"]
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
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = ["${var.vpc_security_group_id}"]
  tags = {
    "Name" = "kworker-n0${count.index+1}"
  }
}