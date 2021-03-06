terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "jcmds"
    workspaces {
      name = "terraform-learning"
    }
  }
}

provider "aws" {
  region                  = var.aws_region
  shared_credentials_file = var.aws_credentials_file
  profile                 = var.aws_profile
}

module "bucket" {
  source                   = "./modules/s3"
  aws_bucket_name          = "my-bucket"
  aws_bucket_create_object = true
}

module "ec2" {
  source = "./modules/ec2"
}