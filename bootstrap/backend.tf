terraform {
backend "s3" {
    bucket = "infra-aws-cicd-pipeline" # The same bucket for both projects
    key    = "bootstrap-tfstate/terraform.tfstate" # A unique key for the bootstrap state
    region = "eu-west-3"
  }
}  