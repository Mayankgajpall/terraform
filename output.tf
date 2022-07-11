output "master_ip" {
    value = [ for instance in aws_instance.master : instance.public_ip ]
}

output "worker_ip" {
    value = [ for instance in aws_instance.worker : instance.public_ip ]
}