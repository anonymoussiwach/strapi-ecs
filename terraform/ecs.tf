resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "strapi-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"

  container_definitions = jsonencode([{
    name      = "strapi"
    image     = var.docker_image  # pass existing ECR image as variable
    essential = true
    portMappings = [{
      containerPort = 1337
      hostPort      = 1337
    }]
  }])
}

resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service"
  cluster         = aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.strapi_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.strapi_subnet_1.id, aws_subnet.strapi_subnet_2.id]
    security_groups = [aws_security_group.strapi_sg.id]
    assign_public_ip = true
  }

  desired_count = 1
}