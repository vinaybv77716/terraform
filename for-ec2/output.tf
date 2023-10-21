output getting_private_ip {
  value       = aws_instance.example.private_ip
  description = "getting private ip"
}

output getting_public_ip{
  value   =aws_instance.example.public_ip
  description="getting public ip"
}