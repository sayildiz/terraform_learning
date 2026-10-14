variable "server_port" {
  description = "The port the server will use for http requests"
  type        = number
  default     = 8080
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the webserver"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "example" {
  ami                    = "ami-0f53e8d52d6e523cf"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World!" > index.html
              nohup python3 -m http.server ${var.server_port} &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-exapmele"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-exapmple-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

