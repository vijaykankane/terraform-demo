
output "web_instance_id" {
  value = aws_instance.web.id
}

output "Public_IP" {
    value = aws_instance.web.public_ip
}
output "db_instance_id" {
  value = aws_instance.db.id
}

