terraform {
  backend "s3" {
    bucket  = "magnolia-tf-backend"
    key     = "envs/dev/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
}

module "infrastructure" {
  source              = "../../modules/infrastructure"
  name                = var.name
  environment         = var.environment
  cidr_block          = var.cidr_block
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  enable_nat_gateway  = var.enable_nat_gateway
}