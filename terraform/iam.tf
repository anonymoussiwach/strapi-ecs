# IAM Role for ECS Tasks with ECR access
resource "aws_iam_role" "ec2_ecr_full_access_role" {
  name = "ec2_ecr_full_access_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}

# Attach ECR full access
resource "aws_iam_role_policy_attachment" "ecr_full" {
  role       = aws_iam_role.ec2_ecr_full_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

# Attach EC2 full access
resource "aws_iam_role_policy_attachment" "ec2_full" {
  role       = aws_iam_role.ec2_ecr_full_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Attach SSM Core
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_ecr_full_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}