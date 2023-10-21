#   creating VPC
resource "aws_vpc" "my_vpc"{
cidr_block=var.cidr
}

#   creating subnet1
resource "aws_subnet" "sub1"{
    vpc_id               =   aws_vpc.my_vpc.id
    cidr_block           =   "10.0.0.0/24"
    availability_zone    =  "us-east-1a"
    map_public_ip_on_launch =   true
}

#   creating subnet2
resource "aws_subnet" "sub2"{
    vpc_id              =   aws_vpc.my_vpc.id
    cidr_block          =   "10.0.1.0/24"
    availability_zone   =   "us-east-1b"
    map_public_ip_on_launch =   true
}

#   creating internet gateway
resource "aws_internet_gateway" "my_gateway"{
     vpc_id=aws_vpc.my_vpc.id
}

#   creating route-table
resource "aws_route_table" "rt"{
     vpc_id=aws_vpc.my_vpc.id

     route{
            cidr_block="0.0.0.0/0"
            gateway_id=aws_internet_gateway.my_gateway.id
     }
}

resource "aws_route_table_association" "rta1"{
    subnet_id=aws_subnet.sub1.id
    route_table_id=aws_route_table.rt.id
}

resource "aws_route_table_association" "rta2"{
    subnet_id=aws_subnet.sub2.id
    route_table_id=aws_route_table.rt.id
}