
# terraform {
#############################################################
## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
## YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
## TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
#############################################################  
#   backend "s3" {
#       bucket = "clxdev-tf-state-1002221202"
#       key = "acg/code-playground/devops-direct-terraform-course/terraform.tfstate"
#       region = "us-east-1"
#       # dynamodb_table = "terraform-state-locking"
#       encrypt = true      
#   }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
# }


provider "aws" {
  region = var.aws_region
}

# resource "aws_s3_bucket" "terraform_state" {
#   bucket        = "clxdev-tf-state-1002221202" #change name of bucket
#   force_destroy = true
# }

# resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
#   bucket = aws_s3_bucket.terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
#   bucket = aws_s3_bucket.terraform_state.bucket
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithm = "AES256"
#     }
#   }
# }

variable "db_pass_01" {
  description = "password for database #1"
  type = string
  sensitive = true  
}

variable "db_pass_01" {
  description = "password for database #2"
  type = string
  sensitive = true  
}

module "web-app-1" {
  source = "../web_app-module"
  
  #input variables
  # bucket_name = "web-app-1-devops-directive-web-app-data"
  domain = "migenjutsu.io"
  app_name = "web-app-1"
  environment_name = "production"
  instance_type = "t2.micro"
  create_dns_zone = true
  db_name = "webapp1db"
  db_user = "foo"
  db_pass = var.db_pass_01
}

module "web-app-2" {
  source = "../web_app-module"
  
  #input variables
  # bucket_name = "web-app-1-devops-directive-web-app-data"
  domain = "migenjutsu.io"
  app_name = "web-app-1"
  environment_name = "production"
  instance_type = "t2.micro"
  create_dns_zone = true
  db_name = "webapp2db"
  db_user = "foo"
  db_pass = var.db_pass_02
}

# ------------------------------------------------

# CODE GRAVEYARD
# Testing Infrastructure

# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
# }

# provider "aws" {
#   region = var.aws_region
# }

# resource "aws_instance" "terraform_instance" {
#   ami           = var.ami_instance
#   instance_type = var.type_instance

# }