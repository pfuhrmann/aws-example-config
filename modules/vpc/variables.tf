variable "environment" {
  type        = string
  description = "Environment to deploy the infrastructure"
  nullable    = false
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the infrastructure"
  nullable    = false
}

variable "name_prefix" {
  type        = string
  description = "Prefix to use for the names of the resources"
  default     = "default"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  nullable     = false
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the public subnets"
  default     = []
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the private subnets"
  default     = []
}
