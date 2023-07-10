resource "aws_db_subnet_group" "imroshan_rds_subnet_group" {
  name       = "${var.project_name}_subnet_group"
  subnet_ids = [var.PRIVATE_SUBNET_ID_1, var.PRIVATE_SUBNET_ID_2]
}
resource "aws_db_instance" "imroshan_rds" {
  engine               = "mysql"
  identifier           = "${var.project_name}-rds"
  allocated_storage    = "10"
  engine_version       = "8.0.32"
  instance_class       = "db.t2.micro"
  username             = "${var.username}"
  password             = "${var.password}"
  db_subnet_group_name = aws_db_subnet_group.imroshan_rds_subnet_group.name
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [var.rds_security_group_id]

  tags = {
    "Name"      = "${var.project_name}_rds"
  }
}
