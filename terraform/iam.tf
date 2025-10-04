# Reference the existing role (do not recreate it)
data "aws_iam_role" "codedeploy_role" {
  name = "codedeploy-role-mayank"
}