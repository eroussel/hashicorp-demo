terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.49.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "dev-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"

  tags = { 
    Name = "dev-vpc"
  }

}

resource "aws_subnet" "app_1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "app_1 subnet"
  }
}