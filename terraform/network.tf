resource "aws_vpc" "strapi_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "strapi-vpc" }
}

resource "aws_subnet" "strapi_subnet_1" {
  vpc_id                  = aws_vpc.strapi_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "strapi_subnet_2" {
  vpc_id                  = aws_vpc.strapi_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_security_group" "strapi_sg" {
  name   = "strapi-sg"
  vpc_id = aws_vpc.strapi_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}