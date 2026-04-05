variable "name" { type = string }
variable "environment" { type = string }
variable "region" { type = string }

variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }

variable "db_endpoint" { type = string }
variable "db_name" { type = string }
variable "db_user" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}

variable "kc_admin_user" { type = string }

variable "bastion_allowed_cidr" { type = string }
variable "bastion_key_name" { type = string }
