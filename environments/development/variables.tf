variable "subdomain" {
  type        = string
  description = "Subdomain to use for the website"
  nullable    = false
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the infrastructure"
  default     = "eu-central-1"
}

variable "hosted_zone_name" {
  type        = string
  description = "Name of the Route 53 hosted zone (eg. code.example.com)"
  nullable    = false
}
