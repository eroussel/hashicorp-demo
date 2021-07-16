terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.49.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "vpc" {
  backend = "remote"
  config = {
    organization = "eroussel-training"
    workspaces = {
      name = "hashicorp-demo-network"
    }
  }
}


data "aws_ami" "amazon_linux_2" {
  owners = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

}

resource "aws_instance" "vm" {
    ami = data.aws_ami.amazon_linux_2.id
    instance_type = "t2.micro"

    subnet_id = data.terraform_remote_state.vpc.outputs.app1_development_subnet

    tags = {
        Name = "Worker VM"
        Environment = "${var.sdlc_environment}"
        Application = "App1"
    }
}

resource "aws_instance" "newvm" {
    ami = data.aws_ami.amazon_linux_2.id
    instance_type = "t2.micro"

    subnet_id = data.terraform_remote_state.vpc.outputs.app1_development_subnet

    tags = {
        Name = "New Worker VM"
        Application = "App1"
    }
}