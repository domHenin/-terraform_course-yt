# terraform {
#     required_providers {
#         aws = {
#             sourcsource = "hashicorp/aws"
#             versversion = "~> 3.0"
#         }
#     }
# }

provider "aws" {
  region = var.aws_region
}
