#------------------------------------------------------------------------------
# Instance Information
#------------------------------------------------------------------------------
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.oracle_test.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.oracle_test.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.oracle_test.private_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.oracle_test.id
}

output "ssh_key_name" {
  description = "Name of the SSH key pair"
  value       = aws_key_pair.oracle_test.key_name
}

output "ssh_private_key_secret_arn" {
  description = "ARN of the secret containing the SSH private key"
  value       = aws_secretsmanager_secret.ssh_private_key.arn
  sensitive   = true
}

output "ssh_command" {
  description = "SSH command to connect to the instance (retrieve private key from Secrets Manager first)"
  value       = "aws secretsmanager get-secret-value --secret-id ${aws_secretsmanager_secret.ssh_private_key.name} --query SecretString --output text > oracle-test-key.pem && chmod 400 oracle-test-key.pem && ssh -i oracle-test-key.pem ec2-user@${aws_instance.oracle_test.public_ip}"
}
