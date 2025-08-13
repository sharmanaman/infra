terraform {
  backend "s3" {
    bucket = "infra-aws-cicd-pipeline"
    key    = "terraform.tfstate"
    region = "eu-west-3"
  }
}