resource "aws_s3_bucket" "example"{
    bucket=var.bucket #bucketname=mys3bucketforremotebackend
}



resource "aws_instance" "example" {
    ami           = var.ami_value # Specify an appropriate AMI ID
    instance_type = var.instance_type
    subnet_id=var.subnet_id
}
