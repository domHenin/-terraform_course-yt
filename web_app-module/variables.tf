variable "aws_region" {
  description = "location of infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of ec2 instance"
  type        = string
  default     = "web-app"
}

variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
  default     = "dev"
}

# EC2 Variables

variable "ami_instance" {
  description = "Ubunutu 20.04 ami lookup"
  type        = string
  default     = "ami-0149b2da6ceec4bb0" # Ubuntu 20.04 LTS //us-east-1
}

variable "type_instance" {
  description = "type of desired instance"
  type        = string
  default     = "t2.micro"
}

# S3 Variables

# variable "bucket_name" {
#   description = "name of s3 bucket for app data"
#   type        = string
# }

# variable "s3_data_tag" {
#   description = "tag name for data bucket"
#   type        = string
# }

# Route 53 Variables

# variable "create_dns_zone" {
#   description = "If true, create new route53 zone, if false read existing route53 zone"
#   type        = bool
#   default     = false
# }


# variable "domain" {
#   description = "domain for website"
#   type        = string
# }

# RDS Variables

# variable "db_name" {
#   description = "name for selected database"
#   type        = string
# }

# variable "db_user" {
#   description = "user for selected datebase"
#   type        = string
#   # default = "foo"
# }

# variable "db_pass" {
#   description = "password for database"
#   type        = string
#   sensitive   = true
# }