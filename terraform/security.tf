resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = "arn:aws:iam::145065858967:role/ec2_ecr_full_access_role"  # existing role

  container_definitions = jsonencode([{
    name      = "strapi"
    image     = var.docker_image
    cpu       = 512
    memory    = 1024
    essential = true
    portMappings = [{
      containerPort = 1337
      hostPort      = 1337
    }]
  }])
}
resource "aws_security_group" "strapi_sg" {
  name        = "strapi-sg-mayank"  # you can append random suffix if needed
  description = "Allow HTTP access to Strapi"
  vpc_id      = data.aws_vpc.default.id

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