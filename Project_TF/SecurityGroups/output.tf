output "INSTANCE_SG_ID" {
  value = aws_security_group.instance_security_group.id
}

output "rds_security_group_id" {
  value = aws_security_group.rds_security_group.id
}