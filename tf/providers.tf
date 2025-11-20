

terraform {

  backend "s3" {
    bucket         = "vijay-terraform-assignment"
    key            = "assignent/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "vijay-assignment-lock"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "eu-central-1"
  profile = "default"
}