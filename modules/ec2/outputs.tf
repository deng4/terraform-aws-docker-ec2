output "ec2_public_ip" {
 value = aws_instance.myec2.public_ip 
}

output "public_dns" {
 value = aws_instance.myec2.public_dns
}

output "ip_adress" {
  value = aws_vpc.main.cidr_block
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_id" {
  value = aws_subnet.docker_subnet.id
  
}