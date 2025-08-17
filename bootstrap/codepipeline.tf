resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "ns-codepipeline-bucket-1234"
  region = "eu-west-3"
}

resource "aws_codestarconnections_connection" "github" {
  name          = "github-connection"
  provider_type = "GitHub"
  region = "eu-west-3"
}


resource "aws_codepipeline" "codepipeline" {
  name     = "Terraform-Apply-pipeline"
  role_arn = aws_iam_role.deploy_role.arn
  region = "eu-west-3"

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "sharmanaman/infra"
        BranchName       = "master"
      }
    }
  }

  stage {
    name = "Terraform-Plan"

    action {
      name             = "Terraform-Plan"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      version          = "1"

      configuration = {
        ProjectName = "terraform_plan"
      }
    }
  }

  stage {
    name = "Manual-Approval"

    action {
      name            = "Manual-Approval"
      category        = "Approval"
      owner           = "AWS"
      provider        = "Manual"
      version         = "1"
    }
  }

  stage {
    name = "Terraform-Apply"

    action {
      name             = "Terraform-Apply"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      version          = "1"

      configuration = {
        ProjectName = "terraform_apply"
      }
    }
  }

  stage {
    name = "Manual-Approval-For-Destroy"

    action {
      name            = "Manual-Approval-For-Destroy"
      category        = "Approval"
      owner           = "AWS"
      provider        = "Manual"
      version         = "1"
    }
  }

  stage {
    name = "Terraform-Destroy"

    action {
      name             = "Terraform-Destroy"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      version          = "1"

      configuration = {
        ProjectName = "terraform_destroy"
      }
    }
  }
}
