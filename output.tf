# output.tf

output "ec2_public_ip" {
  description = "public IP EC2 instance"
  value       = aws_instance.testinstance.public_ip
}

output "ec2_key_name" {
  description = " (PEM file) "
  value       = aws_key_pair.deployer.key_name
}
