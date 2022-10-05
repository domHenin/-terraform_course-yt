output "instance_1_ip_addr" {
  value = aws_instance.server_1.public_ip
}

output "instance_2_ip_addr" {
  value = aws_instance.server_2.public_ip
}

# output "db_instance_addr" {
#     value = aws_db_instance.db_instance.address  
# }