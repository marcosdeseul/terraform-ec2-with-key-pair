locals {
  ami_map = { ubuntu: data.aws_ami.ubuntu.id, centos: data.aws_ami.centos.id }
  ami = var.ami == "" ? local.ami_map[var.os] : var.ami
}
