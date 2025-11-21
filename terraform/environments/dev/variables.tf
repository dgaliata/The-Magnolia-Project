variable "name"                 { type = string }
variable "environment"          { type = string }
variable "region"               { type = string }
variable "cidr_block"           { type = string }
variable "public_subnet_cidr_a" { type = string }
variable "public_subnet_cidr_b" { type = string }
variable "private_subnet_cidr_a"{ type = string }
variable "private_subnet_cidr_b"{ type = string }

variable "pg_db_name"  { type = string }
variable "pg_username" { type = string }

variable "kc_admin_user" { type = string }
variable "kc_admin_password" {
  type      = string
  sensitive = true
}

variable "bastion_allowed_cidr" { type = string }
