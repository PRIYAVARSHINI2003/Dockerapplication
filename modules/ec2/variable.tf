variable "security_groups" {
  type        = list(string)
  description = "security group id's"
}

variable "subnet_id" {
  type        = string
  description = "subnet id"
}

