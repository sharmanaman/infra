resource "aws_codebuild_project" "terraform_plan" {
  name         = "terraform_plan"
  service_role = aws_iam_role.deploy_role.arn
  region = "eu-west-3"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "public.ecr.aws/hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/sharmanaman/infra.git"
    buildspec = file("${path.module}/buildspec/plan-buildspec.yml")
    auth {
      type     = "CODECONNECTIONS"
      resource = aws_codestarconnections_connection.github.arn
    }
  }
}

resource "aws_codebuild_project" "terraform_apply" {
  name         = "terraform_apply"
  service_role = aws_iam_role.deploy_role.arn
  region = "eu-west-3"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "public.ecr.aws/hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/sharmanaman/infra.git"
    buildspec = file("${path.module}/buildspec/apply-buildspec.yml")
    auth {
      type     = "CODECONNECTIONS"
      resource = aws_codestarconnections_connection.github.arn
    }
  }
}

resource "aws_codebuild_project" "terraform_destroy" {
  name         = "terraform_destroy"
  service_role = aws_iam_role.deploy_role.arn
  region = "eu-west-3"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "public.ecr.aws/hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/sharmanaman/infra.git"
    buildspec = file("${path.module}/buildspec/destroy-buildspec.yml")
    auth {
      type     = "CODECONNECTIONS"
      resource = aws_codestarconnections_connection.github.arn
    }
  }
}