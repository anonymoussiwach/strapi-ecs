resource "aws_iam_role_policy_attachment" "ecs_exec_ecr" {
  role       = aws_iam_role.strapi_ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}