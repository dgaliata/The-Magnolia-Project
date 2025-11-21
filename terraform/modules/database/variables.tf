variable "name" { type = string }
variable "environment" { type = string }
variable "vpc_id" { type = string }
variable "private_subnets" { type = list(string) }
variable "pg_db_name" { type = string }
variable "pg_username" { type = string }
