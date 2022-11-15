data "aws_ami" "centos" {
  owners      = ["679593333241"]
  most_recent = true

  filter {
      name   = "name"
      values = ["CentOS Linux 7 x86_64 HVM EBS *"]
  }

  filter {
      name   = "architecture"
      values = ["x86_64"]
  }

  filter {
      name   = "root-device-type"
      values = ["ebs"]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# https://stackoverflow.com/questions/49743220/how-do-i-create-a-ssh-key-in-terraform-aws
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_file" "pem_file" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${var.pem_location}/${var.key_name}/${var.key_name}.pem"
  file_permission = "0600"
}

resource "local_file" "access_shell_script" {
  content         = "ssh -i ./${var.key_name}.pem ${var.os}@${module.this.public_ip[0]}"
  filename        = "${var.pem_location}/${var.key_name}/${var.key_name}.sh"
  file_permission = "0500"
}

## https://learn.hashicorp.com/tutorials/terraform/module-use
module "this" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.12.0"

  name           = "public-ec2-${var.key_name}"
  instance_count = 1

  ami           = local.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  # vpc_security_group_ids = [module.vpc.default_security_group_id]
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.public_subnet_id

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.volume_size
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
