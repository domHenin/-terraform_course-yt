variable "aws_region" {
  description = "location of infrastructure"
  type        = string
  default     = "us-east-1"
}

variable "ami_instance" {
  description = "Ubunutu 20.04 ami lookup"
  type        = string
  default     = "ami-011899242bb902164"
}

variable "type_instance" {
  description = "type of desired instance"
  type        = string
  default     = "t2.micro"
}