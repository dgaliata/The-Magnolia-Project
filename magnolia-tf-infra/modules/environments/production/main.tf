provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "../../modules/vpc"
  name                = "magnolia-prod"
  environment         = "prod"
  cidr_block          = "10.2.0.0/16"
  public_subnet_cidr  = "10.2.1.0/24"
  private_subnet_cidr = "10.2.2.0/24"
  availability_zone   = "us-east-1a"
}
