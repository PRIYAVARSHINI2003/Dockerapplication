resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "codebuild.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


# Allows CodeBuild to push/pull Docker images from ECR
resource "aws_iam_role_policy_attachment" "codebuild_ecr" {

  role = aws_iam_role.codebuild_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}


# Allows CodeBuild to write build logs to CloudWatch
resource "aws_iam_role_policy" "codebuild_logs" {

  name = "codebuild-cloudwatch-logs"

  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      }

    ]
  })
}


# Allows CodeBuild to access S3 artifacts from CodePipeline
resource "aws_iam_role_policy" "codebuild_s3" {

  name = "codebuild-s3-access"

  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]

        Resource = "*"
      }

    ]
  })
}