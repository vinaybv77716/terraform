output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.sub1.id
}

output "aws_security_group_id" {
  value = aws_security_group.mysg.id
}

output "instance_public_ip" {
  value = aws_instance.webserver1.public_ip
}

output "instance_private_ip" {
  value = aws_instance.webserver1.private_ip
}

output "ebs_volume_id" {
  value = aws_ebs_volume.example_volume.id
}
