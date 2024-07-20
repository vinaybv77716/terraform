variable "cidr" {
  default     = "10.0.0.0/16"
  description = "cider block range"
}

#Subnet CIDR
variable "sub_cidr" {
  default     = "10.0.0.0/24"
  description = "cider block of a subnet"
}

#Subnet availability_zone
variable "sub_az" {
  default     = "us-east-1a"
  description = "availability_zone for subnet"
}

#Amazon Mashin images
variable "amis" {
  default     = "ami-04a81a99f5ec58529"
  description = "ubuntu images"
}

#Instance type
variable "inst_tyoe" {
  default     = "t2.micro"
  description = "t2 micro type"
}

#volume size in gb
variable "size" {
  default     = "30"
  description = "30 gb of volume is creating and attaching"
}
