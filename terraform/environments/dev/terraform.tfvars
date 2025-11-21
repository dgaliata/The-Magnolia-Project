name        = "magnolia-dev"
environment = "dev"
region      = "us-east-1"

cidr_block  = "10.0.0.0/16"

public_subnet_cidr_a  = "10.0.1.0/24"
public_subnet_cidr_b  = "10.0.2.0/24"
private_subnet_cidr_a = "10.0.11.0/24"
private_subnet_cidr_b = "10.0.12.0/24"

pg_db_name  = "magnolia"
pg_username = "appadmin"

kc_admin_user     = "admin"
kc_admin_password = "ChangeMeNow!"

bastion_allowed_cidr = "67.180.76.44/32"
