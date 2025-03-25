terraform {
  backend "s3" {
    bucket       = "magnolia-tf-backend"
    key          = "envs/dev/terraform.tfstate"
    use_lockfile = true
    region       = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "../../modules/vpc"
  name                = "magnolia-dev"
  environment         = "dev"
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
  enable_nat_gateway = false
}
