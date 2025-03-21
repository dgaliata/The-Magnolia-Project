provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "../../modules/vpc"
  name                = "magnolia-staging"
  environment         = "staging"
  cidr_block          = "10.1.0.0/16"
  public_subnet_cidr  = "10.1.1.0/24"
  private_subnet_cidr = "10.1.2.0/24"
  availability_zone   = "us-east-1a"
  enable_nat_gateway = false
}
