# database for s3 backend
# resource "aws_dynamodb_table" "terraform_locks" {
#     name = "terraform-state-locking"
#     billing_mode = "PAY_PER_REQUEST"
#     hash_key = "LockID"
#     attribute {
#       name = "LockID"
#       type = "S"
#     }  
# }

# database for data consumption
# resource "aws_db_instance" "db_instance" {
#   allocated_storage   = 20
#   storage_type        = "standard"
#   engine              = "postgres"
#   engine_version      = "12.5"
#   instance_class      = "db.t2.micro"
#   name                = var.db_name
#   username            = var.db_user
#   password            = var.db_pass
#   skip_final_snapshot = true
# }