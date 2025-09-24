# ECS Execution Role
resource "aws_iam_role" "strapi_ecs_execution_role" {
  name = "strapi-ecs-execution"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}

# Attach managed policy for ECS to pull images from ECR
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.strapi_ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
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