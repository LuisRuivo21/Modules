# VPC
#----------------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.project_name}-vpc"
  }
}


# SUBNETS
#----------------------------------------------------

# Public Subnets
#----------------------------------------------------
resource "aws_subnet" "public_subnets" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 100)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name   = "${var.project_name}-${each.key}"
    Subnet = "Public"

  }
}

# Private Subnets
#----------------------------------------------------
resource "aws_subnet" "private_subnets" {
  for_each                = var.private_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, each.value + 1)
  availability_zone       = tolist(data.aws_availability_zones.available.names)[each.value]
  map_public_ip_on_launch = var.map_public_ip_on_launch # without this argument we cannot ssh into our ec2 instances in the private subnets.

  tags = {
    Name   = "${var.project_name}-${each.key}"
    Subnet = "Private"
  }
}


# INTERNET GATEWAY
#----------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}


# ELASTIC IP
#----------------------------------------------------
resource "aws_eip" "eip" {
  vpc        = true # change this? deprecated...
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "${var.project_name}-eip"
  }
}


# NAT GATEWAY
#----------------------------------------------------
resource "aws_nat_gateway" "nat_gw" {
  depends_on    = [aws_internet_gateway.igw]
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnets["public-subnet-1"].id

  tags = {
    Name = "${var.project_name}-nat-gw"
  }
}


# ROUTE TABLES for Public & Private Subnets
#----------------------------------------------------

# Public Route Table
#----------------------------------------------------
resource "aws_default_route_table" "public_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  route {
    cidr_block = var.all_traffic
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Private Route Table
#----------------------------------------------------
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = var.all_traffic
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}


# ROUTE TABLES ASSOCIATION for Public & Private Subnets
#-------------------------------------------------------

# Public Route Table Association
#----------------------------------------------------
resource "aws_route_table_association" "public" {
  depends_on     = [aws_subnet.public_subnets]
  route_table_id = aws_default_route_table.public_rt.id
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
}

# Private Route Table Association.
#----------------------------------------------------
resource "aws_route_table_association" "private" {
  depends_on     = [aws_subnet.private_subnets]
  route_table_id = aws_route_table.private_rt.id
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
}
