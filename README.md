# terraform-ec2-with-key-pair

A Terraform module for EC2 to create a key pair automatically

## How to use

This code below will create an EC2 instance with a key file in `certs/ec2-with-key-pair/` folder

```terraform
module "ec2-with-key-pair" {
  source       = "git@github.com:marcosdeseul/terraform-ec2-with-key-pair.git"
  key_name     = "ec2-with-key-pair"
  pem_location = "${path.module}/certs"

  security_group_ids = [aws_security_group.YOUR_SECURITY_GROUP.id]
  public_subnet_id   = module.YOUR_VPC.public_subnets[0]

  instance_type = "m5.xlarge"
  volume_size   = 64
}

output "ec2-with-key-pair-ip" {
  value       = module.ec2-with-key-pair.ec2_ip
  description = "EC2 Public IP"
}
```
