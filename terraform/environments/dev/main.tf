terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws    = { source = "hashicorp/aws",    version = "~> 5.55" }
    random = { source = "hashicorp/random", version = "~> 3.6"  }
  }

  backend "s3" {
    bucket  = "magnolia-tf-backend"
    key     = "envs/dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.region

}

module "networking" {
  source                = "../../modules/networking"
  name                  = var.name
  environment           = var.environment
  region                = var.region
  cidr_block            = var.cidr_block
  public_subnet_cidr_a  = var.public_subnet_cidr_a
  public_subnet_cidr_b  = var.public_subnet_cidr_b
  private_subnet_cidr_a = var.private_subnet_cidr_a
  private_subnet_cidr_b = var.private_subnet_cidr_b
}

module "database" {
  source          = "../../modules/database"
  name            = var.name
  environment     = var.environment
  vpc_id          = module.networking.vpc_id
  private_subnets = module.networking.private_subnets
  pg_db_name      = var.pg_db_name
  pg_username     = var.pg_username
}

module "compute" {
  source               = "../../modules/compute"
  name                 = var.name
  environment          = var.environment
  region               = var.region
  vpc_id               = module.networking.vpc_id
  public_subnets       = module.networking.public_subnets
  private_subnets      = module.networking.private_subnets
  db_endpoint          = module.database.db_endpoint
  db_name              = var.pg_db_name
  db_user              = var.pg_username
  db_password          = module.database.db_admin_password
  kc_admin_user        = var.kc_admin_user
  kc_admin_password    = var.kc_admin_password
  bastion_allowed_cidr = var.bastion_allowed_cidr
}

module "security" {
  source                = "../../modules/security"
  name                  = var.name
  environment           = var.environment
  region                = var.region
  vpc_id                = module.networking.vpc_id
  vpc_cidr              = var.cidr_block
  private_subnets       = module.networking.private_subnets
  public_route_table_id = module.networking.public_route_table_id
}

output "bastion_public_ip" {
  value = module.compute.bastion_public_ip
}

output "rds_endpoint" {
  value = module.database.db_endpoint
}

output "keycloak_service_name" {
  value = module.compute.keycloak_service_name
}

output "wazuh_internal_dns" {
  value = module.security.wazuh_internal_dns
}

output "wazuh_security_group_id" {
  value = module.security.wazuh_security_group_id
}
