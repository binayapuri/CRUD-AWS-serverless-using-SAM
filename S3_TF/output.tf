output "website_url" {
  description = "URL of the website"
  value       = aws_s3_bucket_website_configuration.s3_ppt_conf.website_endpoint
}