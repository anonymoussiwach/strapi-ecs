terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-state-bucket"   # change this
    key            = "strapi/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"             # optional but recommended
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}