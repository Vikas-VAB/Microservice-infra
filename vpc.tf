resource "aws_subnet" "myapp-subnet" {
  count = "${length(var.subnet_cidrs_public)}"
  vpc_id = "${aws_vpc.myapp-vpc.id}"
  cidr_block = "${var.subnet_cidrs_public[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"
  map_public_ip_on_launch = true
  tags = {
    Name        = "${element(var.availability_zones, count.index)}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.myapp-vpc.id}"
  count                   = "${length(var.private_subnets_cidr)}"
  cidr_block              = "${element(var.private_subnets_cidr, count.index)}"
  availability_zone       = "${element(var.availability_zones,   count.index)}"
  map_public_ip_on_launch = false
  tags = {
    Name        = "${element(var.availability_zones, count.index)}-private-subnet"
  }
}

resource "aws_vpc" "myapp-vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "Micro-vpc"
  }
}

resource "aws_internet_gateway" "test_gateway" {
  vpc_id = aws_vpc.myapp-vpc.id

  tags = {
    Name = "Micro_gateway"
  }
}

resource "aws_route_table" "test_route" {
  vpc_id = aws_vpc.myapp-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_gateway.id
  }

  tags = {
    Name = "Micro-route"
  }
}

resource "aws_route_table_association" "associate" {
  count = "${length(var.subnet_cidrs_public)}"

  subnet_id      = "${element(aws_subnet.myapp-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.test_route.id}"
}

