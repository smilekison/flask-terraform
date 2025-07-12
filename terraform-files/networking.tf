resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    "Name" = "python_vpc_app"
  }
}

resource "aws_subnet" "flask-subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    tags = {
      "Name" = "Flask_subnet" 
    }   
}

resource "aws_internet_gateway" "flask_gateway" {
    vpc_id = aws_vpc.main.id
    tags = {
      "Name" = "flask-gateway"
    }
}

resource "aws_route_table" "flask_routetable" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "flask_RT"
  }
}

resource "aws_route" "rtb-public-rotue" {
    route_table_id = aws_route_table.flask_routetable.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.flask_gateway.id
    
}

resource "aws_route_table_association" "flask-association" {
    subnet_id = aws_subnet.flask-subnet.id
    route_table_id = aws_route_table.flask_routetable.id
}