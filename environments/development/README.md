# Development Environment

This directory contains the Terraform configuration for the development environment.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_elb_public"></a> [elb\_public](#module\_elb\_public) | ../../modules/elb-public | n/a |
| <a name="module_nat"></a> [nat](#module\_nat) | ../../modules/nat | n/a |
| <a name="module_simple_website"></a> [simple\_website](#module\_simple\_website) | ../../modules/ec2-private | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the infrastructure | `string` | `"eu-central-1"` | no |
| <a name="input_hosted_zone_name"></a> [hosted\_zone\_name](#input\_hosted\_zone\_name) | Name of the Route 53 hosted zone (eg. code.example.com) | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain to use for the website | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_website_url"></a> [website\_url](#output\_website\_url) | The URL of the EC2 instance where the application is running |
<!-- END_TF_DOCS -->
