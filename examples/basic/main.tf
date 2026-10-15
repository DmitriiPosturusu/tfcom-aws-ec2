provider "aws" {
  region = var.aws_region
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "instance" {
  source = "../.."

  name               = "demo-instance"
  ami_id             = data.aws_ami.amazon_linux_2023.id
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
  instance_type      = "t3.micro"
}

output "instance_id" {
  value = module.instance.instance_id
}
