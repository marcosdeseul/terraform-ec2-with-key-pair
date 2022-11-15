locals {
  ami = var.ami == "" ? data.aws_ami.ubuntu.id : var.ami
}
