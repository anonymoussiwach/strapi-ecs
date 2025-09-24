# ECS Cluster
resource "aws_ecs_cluster" "strapi_cluster" {
  name = "strapi-cluster-mayank"
}

# ECS Task Definition
resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "strapi-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = var.ecs_execution_role_arn

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

# ECS Service
resource "aws_ecs_service" "strapi_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.strapi_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnet_ids = var.subnet_ids
    security_groups = [aws_security_group.strapi_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.strapi_tg.arn
    container_name   = "strapi"
    container_port   = 1337
  }

  depends_on = [aws_lb_listener.strapi_listener]
}