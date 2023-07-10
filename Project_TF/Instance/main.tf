resource "aws_instance" "imroshan_tf_404" {
  ami           = "${var.instance_ami}"
  instance_type = "t2.micro"
  # vpc_id                      = aws_vpc.VPC_imroshan.id
  subnet_id                   = var.PUBLIC_SUBNET_ID
  key_name                    = "${var.authkey}"
  associate_public_ip_address = "true"
  security_groups   = [var.INSTANCE_SG_ID]
  root_block_device {
    volume_type           = "gp2"
    volume_size           = "8"
    delete_on_termination = true
  }
  tags = {
    "Name"    = "${var.project_name}-instance"
  }
}