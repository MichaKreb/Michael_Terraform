#Outputs
output "instance_id" {
  value = aws_instance.example.host_id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}
