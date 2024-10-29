

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name  = "docker_http_vpc"
    Usage = "install_docker_and_allow_http"
  }
}

resource "aws_main_route_table_association" "ec2_route_table_ass" {
  vpc_id         = aws_vpc.main.vpc_id
  route_table_id = aws_route_table.docker_rt.id
}

resource "aws_route_table" "docker_rt" {
  vpc_id = aws_vpc.main.vpc_id

  route {
    cidr_block = var.allow_all
    gateway_id = aws_internet_gateway.docker_gw.id
  }

  tags = {
    Name = "$(locals.Prefix)_route_table"
  }
}


resource "aws_subnet" "docker_subnet" {
  vpc_id     = aws_vpc.main.vpc_id
  cidr_block = var.subnet_cidr

  depends_on = [aws_internet_gateway.docker_gw]

  tags = {
    Name  = "docker_http_vpc"
    Usage = "install_docker_and_allow_http"
  }
}

resource "aws_network_interface" "docker_ec2_interface" {
  subnet_id       = aws_subnet.docker_subnet.id
  private_ips     = ["10.1.1.13"]
  security_groups = [aws_security_group.allow_ssh_http.id]

}


resource "aws_internet_gateway" "docker_gw" {
  tags = {
    Name = "Docker_ec2_gw"
  }
}

resource "aws_internet_gateway_attachment" "docker_gw_attachment" {
  internet_gateway_id = aws_internet_gateway.docker_gw.id
  vpc_id              = aws_vpc.main.vpc_id
}



resource "aws_security_group" "allow_ssh_http" {
  name   = "allow_ssh"
  vpc_id = aws_vpc.main.vpc_id



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