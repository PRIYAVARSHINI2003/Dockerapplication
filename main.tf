variable "github_token" {
  description = "GitHub OAuth token for CodePipeline source"
  type        = string
  default     = ""
  sensitive   = true
}

module "vpc"{
    source="./modules/vpc"

}

module "security_group"{
    source="./modules/security-group"
    vpc-id=module.vpc.vpcid
}

module "ec2"{
    source="./modules/ec2"
    security_groups = module.security_group.sgid
    subnet_id       = module.vpc.subnetid
}
module "codebuild"{
    source="./modules/codebuild"
}

module "codepipeline"{
    source="./modules/codepipeline"
    project_name = module.codebuild.project_name
    github_token           = var.github_token
    project_arn = module.codebuild.project_arn
}

module "ECR"{
    source="./modules/ECR"
}