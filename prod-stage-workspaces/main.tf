provider "aws"{
    region="us-east-1"
}

variable "ami"{
    description="value"
}

variable "instance"{
    description="t2.micro"
}

module name {
  source = "./module/ec2"
  ami=var.ami
  instance_type=var.instance  
}
