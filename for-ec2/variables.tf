variable ami_value {
  type        = string
  default     = "ami-053b0d53c279acc90"
  description = "ubuntu ami value "
}


variable instance_type{
  type        = string
  default     = "t2.micro"
  description = "value of instance-type "   
}


variable subnet_id{
     type        = string
  default     = "subnet-07d812236e8f63f3b"
  description = "value of Subnet-ID" 
}