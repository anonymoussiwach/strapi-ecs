resource "aws_iam_role_policy_attachment" "ecs_exec_ecr" {
  role       = "strapi-ecs-execution-role" # <-- name of your existing role
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}