
# ==========================
variable "region" {
  type = string
  default = "ap-southeast-1"
  description = "Region to use"
}

variable "keypair_path" {
  type = string
  default = "./keypair/aws_ec2_key.pub"
  description = "Path to the keypair to use"
}

variable "keypair_name" {
  type = string
  default = "aws_ec2_key_pair"
  description = "Name of the keypair to use"
}

variable "ami_id" {
  type = string
  default = "ami-02c7683e4ca3ebf58"
  description = "Id of the AMI to use"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
  description = "Type of EC2 instance to create"
}

variable "instance_name" {
  type = string
  default = "ec2_demo_instance"
  description = "Name of the EC2 instance to create"
}

variable "amis" {
  type = map(string)
  default = {
    "ap-southeast-1" = "ami-02c7683e4ca3ebf58"
    "ap-northeast-1" = "ami-054400ced365b82a0"
  }
  description = "Map of AMIs to use for each region"
}