#key value pair
resource "aws_key_pair" "mykey"{
key_name="vinay"
public_key=file(~/.ssh/id_rsa.pub)
#C:\Users\User/.ssh/id_rsa
}

#creating vpc
resource "aws_vpc" "creating-vpc "{
cidr=var.cidr
}

#creating subnet
resource "aws_subnet" "sub1" {
    vpc_id=aws_vpc.creating-vpc.id
    cidr="10.0.0.0/24"
    availability_zone="us-east-1a"
    map_public_ip_on_launch=true
}

#creating internet gateway
resource "aws_internet_gateway" "igw"{
    vpc_id=aws_vpc.creating-vpc.id
}

#creating route table and attaching the internet gateway
resource "aws_route_table" "rt" {
    vpc_id=aws_vpc.creating-vpc.id
    route{
        cidr_block="0.0.0.0/0"
        gateway_id=aws_internet_gateway.igw.id
    }
}

#assocation of route table to subnet
resource "aws_route_teble_assocation" "rta1" {
subnet_id=aws_subnet.sub1.id
route_table_id=aws_route_table.rt.id
}

#creating security group in that created vpc
resource "aws_security_group" "sg" {
    name="mysg"
    vpc_id=aws_vpc.creating-vpc.id
    #inbound rules
    ingress{
        description="this is http"
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    #inbound rules
    ingress{
       description="this is ssh"
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
    }
    #outbound rules
    egress{
       description="this is http"
        from_port=0
        to_port=0
        protocol="-1"
    }
    tags={
        name="mysg"
    }
}

#creating instance
resource "aws_instance" "ec2-instance"{
    ami="ami-053b0d53c279acc90"
    subnet_id=aws_subnet.sub1.is
    instance_type="t2.micro"
    key_name=aws_key_pair.mykey.vinay
    vpc_security_group_ids=[aws_security_group.sg.id]

    #Terraform login to my ec2 instance
    connection{
        type="ssh"
        user="ubuntu"
        private_key=file("~/.ssh/id_rsa.pub")
        hosr=self.public_ip
        }

    #Terraform to copy my file 
    provisioner "file"{
        source="highway.sh"
        destination="/home/ubuntu/highway.sh"
    }   
    #running some comands on ec2 instance
    provisioner "remote-exec"{
        insine=[
            "echo 'hi im from appache 2 server'  "
            "sudo apt update"
            "cd /home/ubuntu"
            "sh highway.sh"
        ]
    } 
}