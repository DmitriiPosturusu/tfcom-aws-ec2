variable "name" {
  description = "Name tag of the EC2 instance."
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the selected AWS Region."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "ID of an existing subnet."
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs attached to the instance."
  type        = list(string)
}

variable "associate_public_ip_address" {
  description = "Whether to assign a public IPv4 address (which can incur AWS charges)."
  type        = bool
  default     = false
}

variable "key_name" {
  description = "Name of an existing EC2 key pair (optional)."
  type        = string
  default     = null
}

variable "user_data" {
  description = "Optional EC2 user data script."
  type        = string
  default     = null
}

variable "root_volume_size" {
  description = "Size in GiB of the encrypted gp3 root EBS volume."
  type        = number
  default     = 8

  validation {
    condition     = var.root_volume_size >= 8
    error_message = "root_volume_size must be at least 8 GiB."
  }
}

variable "tags" {
  description = "Additional tags. Name is set by the module."
  type        = map(string)
  default     = {}
}
