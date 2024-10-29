resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name  = "docker_http_vpc"
    Usage = "install_docker_and_allow_http"
  }
}