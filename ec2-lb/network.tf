resource "aws_vpc" "VPC" {
  cidr_block           = var.vpcCIDRblock

  tags = {
    Name = "VPC-${var.name}"
  }

}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.private_cidr
  availability_zone       = "${var.region}a"

  tags = {
    Name = "Subnet-private-${var.name}"
    Tier = "private"
  }

}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = var.public_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true 

  tags = {
    Name = "Subnet-public-${var.name}"
    Tier = "public"
  }

}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "IGW-${var.name}"
  }

} 

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "RT-${var.name}"
  }

}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

resource "aws_main_route_table_association" "default_route_association" {
  vpc_id         = aws_vpc.VPC.id
  route_table_id = aws_route_table.private.id
}


resource "aws_eip" "EIP" {
  vpc = true

  tags = {
    Name        = "EIP-${var.name}"
  }

}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.EIP.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name        = "NATGW-${var.name}"
  }

  depends_on = [aws_internet_gateway.IGW]

}

resource "aws_route_table" "public" {
  vpc_id            = aws_vpc.VPC.id

  tags = {
    Name = "RT-NAT-${var.name}"
  }

}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.NAT.id
}

resource "aws_route_table_association" "nat_gw_rt_association" {
  subnet_id         = aws_subnet.private.id
  route_table_id    = aws_route_table.public.id
  depends_on        = [aws_instance.apache]
}
