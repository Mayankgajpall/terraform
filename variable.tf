variable "number_of_master_node" {
  type = number
  default = 1
}

variable "number_of_worker_node" {
  type = number
  default = 1
}

variable "master_instance_type" {
  type = string
  default = "t2.micro"
}

variable "worker_instance_type" {
  type = string
  default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
  default = "172.20.0.0/16"
}

variable "subnet_cidr_block" {
  type = string
  default = "172.20.10.0/24"
}