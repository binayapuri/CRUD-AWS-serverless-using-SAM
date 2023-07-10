output "vpc_id" {
  value = aws_vpc.myvpc.id
}
output "PUBLIC_SUBNET_ID" {
  value = aws_subnet.public_subnet_az1.id
}

output "PRIVATE_SUBNET_ID_1" {
  value = aws_subnet.private_data_subnet_az1.id
}
output "PRIVATE_SUBNET_ID_2" {
  value = aws_subnet.private_data_subnet_az2.id
}