# Testing Infrastructure

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "terraform_instance" {
  ami           = var.ami_instance
  instance_type = var.type_instance

}