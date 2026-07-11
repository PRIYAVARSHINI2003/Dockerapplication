resource "aws_codebuild_project" "this"{
    name="docker-application"
    service_role=aws_iam_role.codebuild_role.arn
    artifacts{
        type="NO_ARTIFACTS"

    }
    environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:7.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true   # REQUIRED for Docker
  }

    source{
        type="GITHUB"
        location="https://github.com/PRIYAVARSHINI2003/Dockerapplication.git"
    }

}

