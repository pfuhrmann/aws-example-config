output "ec2_url" {
  value = "http://${aws_route53_record.main.fqdn}"
  description = "The URL of the EC2 instance where the application is running"
}
