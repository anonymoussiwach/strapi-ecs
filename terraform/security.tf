resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg-mayank"
  description = "Allow HTTP access to Strapi"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = [
      { from = 80, to = 80 },
      { from = 1337, to = 1337 }
    ]
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}