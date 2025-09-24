# terraform.tfvars

docker_image = "145065858967.dkr.ecr.ap-south-1.amazonaws.com/strapi-app"

vpc_id = "vpc-01b35def73b166fdc"

subnet_ids = [
  "subnet-0393e7c5b435bd5b6",  # ap-south-1a
  "subnet-03e1b3fe2ad999849"   # ap-south-1b
]

ecs_execution_role_arn = "arn:aws:iam::145065858967:role/ec2_ecr_full_access_role"