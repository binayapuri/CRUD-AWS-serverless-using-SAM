output "rds_endpoint" {
  value = aws_db_instance.imroshan_rds.endpoint
}

output "rds_username" {
  value = aws_db_instance.imroshan_rds.username
}
