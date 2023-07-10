#create VPC
resource "aws_vpc" "myvpc" {
  cidr_block              = var.vpc_cidr
  tags      = {
    Name    = "${var.project_name}-vpc"
  }
}
#retrive available zones on that region
data "aws_availability_zones" "available_zones" {}
# create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  tags      = {
    Name    = "${var.project_name}-public_subnet_az1"
  }
}
# create Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.myvpc.id
  tags      = {
    Name    = "${var.project_name}-igw"
  }
}
# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id       = aws_vpc.myvpc.id
  route {
    cidr_block = "${var.anywhereCIDR}"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags       = {
    Name    = "${var.project_name}-public_RT"
  }
}
# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id           = aws_subnet.public_subnet_az1.id
  route_table_id      = aws_route_table.public_route_table.id
}
# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = aws_vpc.myvpc.id
  cidr_block               = var.data_private_subnet_az1_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[0]
  tags      = {
    Name    = "${var.project_name}-private-data_subnet_az1"
  }
}
# create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                   = aws_vpc.myvpc.id 
  cidr_block               = var.data_private_subnet_az2_cidr
  availability_zone        = data.aws_availability_zones.available_zones.names[1]
  tags      = {
    Name    = "${var.project_name}-private-data_subnet_az2"
  }
}