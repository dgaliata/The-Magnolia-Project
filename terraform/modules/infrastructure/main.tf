resource "aws_vpc" "magnolia_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.magnolia_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.name}-public"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.magnolia_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name        = "${var.name}-private"
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.magnolia_vpc.id
  tags = {
    Name        = "${var.name}-igw"
    Environment = var.environment
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.magnolia_vpc.id
  tags = {
    Name        = "${var.name}-public-rt"
    Environment = var.environment
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
  count = var.enable_nat_gateway ? 1 : 0
  tags = {
    Name = "${var.name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public.id
  depends_on    = [aws_internet_gateway.igw]
  tags = {
    Name = "${var.name}-nat"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.magnolia_vpc.id
  tags = {
    Name        = "${var.name}-private-rt"
    Environment = var.environment
  }
}

resource "aws_route" "private_internet_route" {
  count                  = var.enable_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[0].id
}

resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# EC2 Instance for FastAPI Apps
resource "aws_instance" "app_server" {
  ami           = "ami-0c02fb55956c7d316" 
  instance_type = "t2.micro"              
  
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.app_server.id]
  associate_public_ip_address = true
  
  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y python3 python3-pip git
    
    # Install FastAPI dependencies
    pip3 install fastapi uvicorn boto3
    
    # Create app directory
    mkdir -p /home/ec2-user/apps
    chown ec2-user:ec2-user /home/ec2-user/apps
  EOF
  
  tags = {
    Name        = "${var.name}-app-server"
    Environment = var.environment
  }
}

# Security Group for EC2
resource "aws_security_group" "app_server" {
  name        = "${var.name}-app-server-sg"
  description = "Security group for FastAPI app server"
  vpc_id      = aws_vpc.magnolia_vpc.id
  
  # FastAPI apps
  ingress {
    from_port   = 8000
    to_port     = 8002
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # All outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name        = "${var.name}-app-server-sg"
    Environment = var.environment
  }
}


