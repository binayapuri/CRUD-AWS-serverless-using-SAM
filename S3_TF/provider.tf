terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-2"
  profile = "default"
}

module "template_files" {
  source   = "hashicorp/dir/template"
  base_dir = "${path.module}/web"
}
