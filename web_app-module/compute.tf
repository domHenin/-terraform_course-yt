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