# ECS Task Execution Role
resource "aws_iam_role" "strapi_ecs_mayank" {
  name = "strapi-ecs-mayank"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

# Attach ECS execution managed policy (allows pulling from ECR, logging)
resource "aws_iam_role_policy_attachment" "ecs_exec_managed" {
  role       = aws_iam_role.strapi_ecs_mayank.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Optional: Attach full ECR access (if needed)
resource "aws_iam_role_policy_attachment" "ecr_full" {
  role       = aws_iam_role.strapi_ecs_mayank.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}