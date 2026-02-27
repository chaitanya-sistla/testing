#------------------------------------------------------------------------------
# EC2 Instance Outputs
#------------------------------------------------------------------------------

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.web_server.private_ip
}

output "instance_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

#------------------------------------------------------------------------------
# Security Group Outputs
#------------------------------------------------------------------------------

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web_server.id
}

output "security_group_name" {
  description = "Name of the security group"
  value       = aws_security_group.web_server.name
}