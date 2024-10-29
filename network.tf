


resource "aws_main_route_table_association" "ec2_route_table_ass" {
  vpc_id         = module.vpc.vpc_id
  route_table_id = aws_route_table.docker_rt.id
}

resource "aws_route_table" "docker_rt" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = var.allow_all
    gateway_id = aws_internet_gateway.docker_gw.id
  }

  tags = {
    Name = "$(locals.Prefix)_route_table"
  }
}


resource "aws_subnet" "docker_subnet" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.subnet_cidr

  depends_on = [aws_internet_gateway.docker_gw]

  tags = {
    Name  = "docker_http_vpc"
    Usage = "install_docker_and_allow_http"
  }
}

resource "aws_network_interface" "docker_ec2_interface" {
  subnet_id       = aws_subnet.docker_subnet.id
  security_groups = [aws_security_group.allow_ssh_http.id]

}


resource "aws_internet_gateway" "docker_gw" {
  tags = {
    Name = "Docker_ec2_gw"
  }
}

resource "aws_internet_gateway_attachment" "docker_gw_attachment" {
  internet_gateway_id = aws_internet_gateway.docker_gw.id
  vpc_id              = module.vpc.vpc_id
}
