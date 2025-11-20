variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "key_name" {
  description = "EC2 key pair name to attach to instances (must exist in AWS)."
  type        = string
  default = "vktravel"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH into public instance (your IP e.g. 203.0.113.5/32). Required for security."
  type        = string
  default = "0.0.0.0/0"
}

variable "instance_type_web" {
  type    = string
  default = "t3.medium"
}

variable "instance_type_db" {
  type    = string
  default = "t3.medium"
}
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0a854fe96e0b45e4e" # Example AMI ID for Amazon Linux 2 in eu-central-1
}