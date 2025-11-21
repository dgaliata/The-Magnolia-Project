resource "aws_db_subnet_group" "pg" {
  name       = "${var.name}-pg"
  subnet_ids = var.private_subnets
}

resource "random_password" "pg_password" {
  length  = 20
  special = true
}

resource "aws_security_group" "pg" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "pg" {
  engine                 = "postgres"
  engine_version         = "16.4"
  instance_class         = "db.t4g.micro"
  allocated_storage      = 20
  db_name                = var.pg_db_name
  username               = var.pg_username
  password               = random_password.pg_password.result
  vpc_security_group_ids = [aws_security_group.pg.id]
  db_subnet_group_name   = aws_db_subnet_group.pg.name
  skip_final_snapshot    = true
  storage_encrypted      = true
  multi_az               = false
  publicly_accessible    = false
}

output "db_endpoint" {
  value = aws_db_instance.pg.address
}

output "db_port" {
  value = aws_db_instance.pg.port
}

output "db_admin_user" {
  value = var.pg_username
}

output "db_admin_password" {
  value     = random_password.pg_password.result
  sensitive = true
}
