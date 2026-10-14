provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0e94515e56ea0c11b"
  instance_type = "t3.micro"
  tags = {
    Name = "terraform-exapmele"
  }
}
