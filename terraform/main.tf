resource "aws_instance" "strapi" {
  ami           = "ami-0533167fcff018a86" # Amazon Linux 2023
  instance_type = "t3.small"
  key_name      = var.key_pair
  security_groups = [aws_security_group.strapi.name]

  user_data = <<-EOF
              #!/bin/bash
              # Install Docker
              amazon-linux-extras enable docker
              yum install -y docker
              systemctl start docker
              systemctl enable docker

              # Install AWS CLI v2
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo ./aws/install

              # Log in to ECR
              aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 145065858967.dkr.ecr.ap-south-1.amazonaws.com

              # Pull and run the Strapi container
              docker pull 145065858967.dkr.ecr.ap-south-1.amazonaws.com/strapi-app:latest
              docker run -d -p 80:1337 145065858967.dkr.ecr.ap-south-1.amazonaws.com/strapi-app:latest
              EOF

  tags = {
    Name = "strapi-instance"
  }
}