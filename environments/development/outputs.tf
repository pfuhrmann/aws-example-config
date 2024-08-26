output "website_url" {
  value = module.simple_website.ec2_url
  description = "The URL of the EC2 instance where the application is running"
}
