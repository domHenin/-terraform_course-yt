
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

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
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

# resource "aws_dynamodb_table" "terraform_locks" {
#     name = "terraform-state-locking"
#     billing_mode = "PAY_PER_REQUEST"
#     hash_key = "LockID"
#     attribute {
#       name = "LockID"
#       type = "S"
#     }  
# }

resource "aws_instance" "server01" {
  ami             = var.ami_instance
  instance_type   = var.type_instance
  security_groups = [aws_security_group.server_sg.name]

  tags = {
    "Name" = var.instance_name
  }

  user_data = <<-EOF
          #!/bin/bash
          echo "Hello World from Server01" > insxdex.html
          python3 -m http.server 8080 &
          EOF  
}

resource "aws_instance" "server02" {
  ami             = var.ami_instance
  instance_type   = var.type_instance
  security_groups = [aws_security_group.server_sg.name]

  tags = {
    "Name" = var.instance_name
  }

  user_data = <<-EOF
          #!/bin/bash
          echo "Hello World from Server02" > index.html
          python3 -m http.server 8080 &
          EOF  
}

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

data "aws_vpc" "server_vpc" {
  default = true
}

data "aws_subnet_ids" "server_subnet" {
  vpc_id = data.aws_vpc.server_vpc.id
}

resource "aws_security_group" "server_sg" {
  name = "server-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.server_sg.id

  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn

  port = 80

  protocol = "HTTP"

  #by default return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404

    }
  }
}

resource "aws_lb_target_group" "instances" {
  name     = "example-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.server_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "instance_1" {
  target_group_arn = aws_lb_target_group.instances.arn
  target_id        = aws_instance.server02.id
  port             = 8080
}

resource "aws_lb_listener_rule" "instances" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instances.arn
  }
}

resource "aws_security_group" "alb" {
  name = "alb-security-group"

}

resource "aws_security_group_rule" "allow_alb_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_alb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_lb" "load_balancer" {
  name               = "web-app-lb"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.server_subnet.ids
  security_groups    = [aws_security_group.alb.id]
}

# resource "aws_route53_zone" "primary" {
#   name = "clxdevopsdeployed.com"
# }

# resource "aws_route53_record" "root" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "clxdevopsdeployed.com"
#   type    = "A"

#   alias {
#     name                   = aws_lb.load_balancer.dns_name
#     zone_id                = aws_lb.load_balancer.zone_id
#     evaluate_target_health = true
#   }
# }

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