
terraform {
  #############################################################
  ## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND)
  ## YOU WILL UNCOMMENT THIS CODE THEN RERUN TERRAFORM INIT
  ## TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  #############################################################  
  # backend "s3" {
  #     bucket = "clxdev-tf-state-0929221157"
  #     key = "acg/code-playground/devops-direct-terraform-course/terraform.tfstat"
  #     region = "us-east-1"
  #     # dynamodb_table = "terraform-state-locking"
  #     encrypt = true      
  # }

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

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "clxdev-tf-state-0929221157" #change name of bucket
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# resource "aws_dynamodb_table" "terraform_locks" {
#     name = "terraform-state-locking"
#     billing_mode = "PAY_PER_REQUEST"
#     hash_key = "LockID"
#     attribute {
#       name = "LockID"
#       type = "S"
#     }  
# }



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