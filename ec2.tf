provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami           = "ami-053b0d53c279acc90"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
    subnet_id="subnet-07d812236e8f63f3b"
}
