module "network" {
  source = "./modules/network"
  vpc_cidr_block = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
}

module "instance" {
  source = "./modules/instance"
  number_of_master_node = var.number_of_master_node
  number_of_worker_node = var.number_of_worker_node
  master_instance_type = var.master_instance_type
  worker_instance_type = var.worker_instance_type
  vpc_security_group_id = module.network.vpc.default_security_group_id
  subnet_id = module.network.subnet.id
  key_name = var.key_name
}