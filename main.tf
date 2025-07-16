provider "aws" {
  region = "eu-north-1"  # Change this to your desired region
}


resource "aws_instance" "my_ec2" {
  ami = "ami-0914547665e6a707c"  
  instance_type = "t3.micro"

  tags = {
    Name = "MyEC2Instance"
  }

  # Optional: Add a key pair for SSH access
  key_name = "msj1910"  # Replace with your actual key pair name

  # Optional: Add security group to allow SSH
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Warning: open to all IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

