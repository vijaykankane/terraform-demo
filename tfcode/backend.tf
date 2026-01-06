terraform {
  backend "s3" {
    bucket         = "capstone-g3-2026"
    key            = "capstoneG3.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "capstone-g3-tfstate-lock"
  }
}