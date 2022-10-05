resource "aws_instance" "server_1" {
  ami             = var.ami_instance
  instance_type   = var.instance_type
  # security_groups = [aws_security_group.server_sg.name]
  security_groups = [ aws_security_group.instances.name ]

  tags = {
    "Name" = var.instance_name
  }

  user_data = <<-EOF
          #!/bin/bash
          echo "Hello World from Server01" > insxdex.html
          python3 -m http.server 8080 &
          EOF  
}

resource "aws_instance" "server_2" {
  ami             = var.ami_instance
  instance_type   = var.instance_type
  # security_groups = [aws_security_group.server_sg.name]
    security_groups = [ aws_security_group.instances.name ]

  tags = {
    "Name" = var.instance_name
  }

  user_data = <<-EOF
          #!/bin/bash
          echo "Hello World from Server02" > index.html
          python3 -m http.server 8080 &
          EOF  
}
