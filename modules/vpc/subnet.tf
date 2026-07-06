resource "aws_subnet" "privatethis" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.az.names[0]
}

resource "aws_subnet" "publicthis" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.az.names[1]
}



resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.this.id
    
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "publicassoc"{
    subnet_id =aws_subnet.publicthis.id
    route_table_id=aws_route_table.public-route-table.id

}

resource "aws_nat_gateway" "this" {
  vpc_id     = aws_vpc.this.id
  subnet_id = aws_subnet.privatethis.id
}


resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.this.id
  }
}

resource "aws_route_table_association" "privateassoc" {
  subnet_id      = aws_subnet.privatethis.id
  route_table_id = aws_route_table.private-route-table.id
}

