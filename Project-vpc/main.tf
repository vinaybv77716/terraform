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


#creating security group
resource   "aws_security_group" "mysg"{
    name="mysg"
    description="creating securit group"
    vpc_id=aws_vpc.my_vpc.id
     ingress{
        description="http"
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_block=["0.0.0.0/0"]

    }
     ingress{
        description="ssh"
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_block=["0.0.0.0/0"]
    }
    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_block=["0.0.0.0/0"]
    }
    tags={
        name="my-security-group"
    }
}

# creating s3 bucket
resource "aws_s3_bucket" "vinay"{
    bucket="vinay_pruthiv_s3_bucket_hosting_web_server_in_s3_bucket"
    tags={
        name="my bucket"
    }
}
#creating ec2 instances
resource "aws_instance" "webserver1"{
ami="ami-053b0d53c279acc90"
instance_type="t2.micro"
vpc_security_group_ids=[aws_security_group.mysg.id]
subnet_id=aws_subnet.sub1.id
key_name="vinay"
user_data= base64encode(file("ec2-instance-1.sh"))
}

resource "aws_instance" "webserver2"{
ami="ami-053b0d53c279acc90"
instance_type="t2.micro"
vpc_security_group_ids=[aws_security_group.mysg.id]
subnet_id=aws_subnet.sub2.id
key_name="vinay"
user_data= base64encode(file("ec2-instance-2.sh"))
}