

resource "aws_security_group" "allow_ssh_http" {
  name   = "allow_ssh"
  vpc_id = module.vpc.vpc_id



  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["${var.my_ip}/32"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allow_all]
  }
}

# resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
#   security_group_id = aws_security_group.allow_ssh_http.id
#   cidr_ipv4         = "${var.my_ip}/32"
#   ip_protocol       = "tcp"
#   from_port         = var.ssh_port
#   to_port           = var.ssh_port
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_http" {
#   security_group_id = aws_security_group.allow_ssh_http.id
#   cidr_ipv4         = "${var.my_ip}/32"
#   ip_protocol       = "tcp"
#   from_port         = var.http_port
#   to_port           = var.http_port
# }

# resource "aws_vpc_security_group_egress_rule" "name" {
#   security_group_id = aws_security_group.allow_ssh_http.id
#   ip_protocol       = -1
#   cidr_ipv4         = "0.0.0.0/0"

# }

# resource "aws_vpc_security_group_ingress_rule" "dynamic_roules" {
#   security_group_id = aws.security_group_id.id
#   cidr_ipv4 = "$(var.my_up)/32"
#   ip_protocol = "tcp"
# }