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

variable "vpc_security_group_id" {
  type = string
}

variable "subnet_id" {
  type = string
}
