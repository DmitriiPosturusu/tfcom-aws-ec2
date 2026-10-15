variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "subnet_id" {
  description = "ID of an existing subnet."
  type        = string
}

variable "security_group_ids" {
  description = "IDs of existing security groups."
  type        = list(string)
}
