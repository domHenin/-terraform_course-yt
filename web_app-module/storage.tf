# resource "aws_s3_bucket" "data_bucket" {
#   bucket = "devops-directive-web-app-data"
#   force_destroy = true
# versioning {
#   enabled = true
# }

# tags = {
#   Name = var.s3_data_tag
# }

# server_side_encryption {
#   rule {
#     apply_server_side_encryption_by_default {
#       sse_algorithim = "AES256"
#     }
#   }
# }
# }