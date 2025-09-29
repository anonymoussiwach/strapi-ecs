terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "mayank-terraform-bucket"   # change this
    key            = "strapi/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}