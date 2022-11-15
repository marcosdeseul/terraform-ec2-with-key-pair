output "ec2_ip" {
  value       = module.this.public_ip[0]
  description = "Public EC2 IP"
}

output "ec2_id" {
  value       = module.this.id
  description = "Public EC2 ID"
}

output "ami" {
  value = local.ami
}

output "private_key" {
  value = tls_private_key.this
}
