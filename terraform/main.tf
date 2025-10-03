# ===========================
# ECS Cluster
# ===========================
resource "aws_ecs_cluster" "strapi_cluster" {
  name = "strapi-cluster-mayank"
}

# ===========================
# ECS Task Definition
# ===========================
resource "aws_ecs_task_definition" "strapi_task" {
  family                   = "strapi-task-mayank"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = "arn:aws:iam::145065858967:role/ecsTaskExecutionRole"
  task_role_arn            = "arn:aws:iam::145065858967:role/ecsTaskExecutionRole"

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
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.strapi_logs.name
        awslogs-region        = "ap-south-1"
        awslogs-stream-prefix = "ecs/strapi"
      }
    }
  }])
}

# ===========================
# ECS Service (Blue/Green with CodeDeploy)
# ===========================
resource "aws_ecs_service" "strapi_service" {
  name            = "strapi-service-mayank"
  cluster         = aws_ecs_cluster.strapi_cluster.id
  task_definition = aws_ecs_task_definition.strapi_task.arn
  desired_count   = 1

  # Blue/Green Deployment with CodeDeploy
  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [aws_security_group.strapi_sg.id]
    assign_public_ip = true
  }
  
  depends_on = [aws_lb_listener.strapi_listener]
}