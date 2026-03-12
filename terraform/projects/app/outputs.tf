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

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.ec2_instance.id
}

output "key_pair_name" {
  description = "Name of the SSH key pair"
  value       = aws_key_pair.ec2_key.key_name
}

#------------------------------------------------------------------------------
# Network Information
#------------------------------------------------------------------------------

output "vpc_id" {
  description = "VPC ID from remote state"
  value       = data.terraform_remote_state.network.outputs.vpc_id
}

output "ssh_connection_string" {
  description = "SSH connection command"
  value       = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_ip}"
}
