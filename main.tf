provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# 1. Create a Security Group to allow traffic
resource "aws_security_group" "web_sg" {
  name        = "devops-project-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to world (for demo only)
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic to our Flask App
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Create the EC2 Instance
resource "aws_instance" "app_server" {
  ami           = "ami-0c7217cdde317cfec" # Ubuntu 22.04 LTS (US-East-1). Update if using different region!
  instance_type = "t2.micro"              # Free tier eligible
  key_name      = "practice_ec2_key"    # You MUST create this key manually in AWS Console first!

  
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # User data script to install Docker on startup
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y docker.io
              sudo usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "python_app_instance"
  }
}

# 3. Output the Public IP so we know where to connect
output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}