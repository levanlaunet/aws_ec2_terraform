# https://registry.terraform.io/providers/hashicorp/aws/latest
terraform {
  required_version = ">=1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.40"
    }
  }
}

# =============================

provider "aws" {
  region = var.region
}

resource "aws_key_pair" "ec2_demo_key_pair" {
  key_name = var.keypair_name
  public_key = file(var.keypair_path)
}

resource "aws_instance" "ec2_demo_instance" {
  ami                     = var.amis[var.region]
  instance_type           = var.instance_type
  key_name                = aws_key_pair.aws_ec2_key_pair.key_name 
  tags = {
    Name = var.instance_name
  }
  vpc_security_group_ids = [aws_security_group.ec2_demo_sg.id]
}

resource "aws_security_group" "ec2_demo_sg" {
  name = "ec2_demo_sg"
  description = "ec2_demo_sg_description"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# ============================================

output "instance_ip_address_private" {
  value = aws_instance.ec2_demo_instance.private_ip
}

output "instance_ip_address_public" {
  value = aws_instance.ec2_demo_instance.public_ip
}

output "security_group_id" {
  value = aws_security_group.ec2_demo_sg.id
}