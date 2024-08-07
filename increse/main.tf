#creating a VPC
resource "aws_vpc" "my_vpc"{
cidr_block=var.cidr
}

#   creating a subnet
resource "aws_subnet" "sub1"{
    vpc_id               =   aws_vpc.my_vpc.id
    cidr_block           =   var.sub_cidr
    availability_zone    =  var.sub_az
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
        cidr_blocks=["0.0.0.0/0"]

    }
     ingress{
        description="ssh"
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"]
    }
    tags={
        name="my-security-group"
    }
}


#creating ec2 instances
resource "aws_instance" "webserver1"{
ami=var.amis
instance_type=var.inst_tyoe
vpc_security_group_ids=[aws_security_group.mysg.id]
subnet_id=aws_subnet.sub1.id
key_name="Ex"
user_data= base64encode(file("ec2-instance-1.sh"))

 tags={
        name="my-instance"
    }
}


resource "aws_ebs_volume" "example_volume" {
  availability_zone = var.sub_az
  size              = var.size
}

resource "aws_volume_attachment" "example_attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.example_volume.id
  instance_id = aws_instance.webserver1.id
}


