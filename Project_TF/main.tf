terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
}
provider "aws" {
  region = var.region
}
terraform {
  backend "s3" {
    bucket = "8586-terraform-state"
    region = "us-east-1"
    key    = "terraform.tfstate"
  }
}

module "vpc" {
  source       = "./VPC"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  anywhereCIDR = var.anywhereCIDR

  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  data_private_subnet_az1_cidr = var.data_private_subnet_az1_cidr
  data_private_subnet_az2_cidr = var.data_private_subnet_az2_cidr
}

module "SecurityGroups" {
  source       = "./SecurityGroups"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  anywhereCIDR = var.anywhereCIDR
}

module "Instance" {
  source       = "./Instance"
  project_name = var.project_name
  instance_ami = var.instance_ami
  authkey      = var.authkey

  PUBLIC_SUBNET_ID = module.vpc.PUBLIC_SUBNET_ID
  INSTANCE_SG_ID   = module.SecurityGroups.INSTANCE_SG_ID
}

module "RDS" {
  source              = "./RDS"
  project_name        = var.project_name
  PRIVATE_SUBNET_ID_1 = module.vpc.PRIVATE_SUBNET_ID_1
  PRIVATE_SUBNET_ID_2 = module.vpc.PRIVATE_SUBNET_ID_2

  rds_security_group_id = module.SecurityGroups.rds_security_group_id
  username              = var.username
  password              = var.password
}