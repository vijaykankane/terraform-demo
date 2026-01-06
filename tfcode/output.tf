
output "Public_IP" {
  value = module.ec2.Public_IP
}

output "db_instance_ip" {
  value = module.ec2.db_instance_ip
}
output "ansible_host_web" {
  value = module.ec2.Public_IP-ansible
}