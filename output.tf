output "master_ip" {
    value = [ for instance in module.instance.master_instance : instance.public_ip ]
}

output "worker_ip" {
    value = [ for instance in module.instance.worker_instance : instance.public_ip ]
}