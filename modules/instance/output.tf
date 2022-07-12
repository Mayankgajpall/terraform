output "master_instance" {
    value = aws_instance.master
}

output "worker_instance" {
    value = aws_instance.worker
}