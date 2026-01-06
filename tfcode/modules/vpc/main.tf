resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = { Name = "${var.name}-igw" }
}

# Public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  count = 2
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index) # 10.10.0.0/24
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "${var.name}-public-subnet"  }
}

# Private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  count = 2
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, 2+count.index) # 10.10.1.0/24
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "${var.name}-private-subnet" }
}

# EIP for NAT
resource "aws_eip" "nat_eip" {
  #vpc = true
  depends_on = [aws_internet_gateway.igw]
  tags = { Name = "${var.name}-nat-eip" }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id
  tags = { Name = "${var.name}-nat" }
}

# Route table for public subnet (to IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "${var.name}-public-rt" }
}

resource "aws_route_table_association" "public_assoc_0" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_assoc_1" {
  subnet_id      = aws_subnet.public[1].id
  route_table_id = aws_route_table.public.id
}

# Route table for private subnet (to NAT)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = { Name = "${var.name}-private-rt" }
}

resource "aws_route_table_association" "private_assoc_0" {
  subnet_id      = aws_subnet.private[0].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_assoc_1" {
  subnet_id      = aws_subnet.private[1].id
  route_table_id = aws_route_table.private.id
}
data "aws_availability_zones" "available" {}
