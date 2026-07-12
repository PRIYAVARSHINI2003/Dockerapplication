variable "github_token"{
    description="oauth token"
    type=string
    sensitive=true
    default=""
}
variable "project_arn" {
  description = "ARN of the CodeBuild project used by the pipeline"
  type        = string
}
variable "project_name" {
  description = "Name of the CodeBuild project used by the pipeline"
  type        = string
}