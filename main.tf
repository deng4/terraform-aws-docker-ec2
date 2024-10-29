locals {
  Prefix              = "TMS"
  Usage               = "Docker VM for TMS"
  Owner               = "Dzianis Soika"
  CreationDate        = "date-${formatdate("DDMMMYYYY", timestamp())}"
  StartUpScriptDocker = file("./docker_install.sh")

  instance_type = {
    default = "t2.micro"
    dev     = "t2.medium"
    prod    = "t3a.medium"
  }
}

variable "my_ip" {}

module "my_ec2" {
  source              = "./modules/ec2"
  instance_type       = local.instance_type[terraform.workspace]
  subnet_id           = aws_subnet.docker_subnet.id
  security_groups_ids = aws_security_group.allow_ssh_http.id
  # TAGS SECTION

  Owner        = local.Owner
  Purpose      = local.Usage
  CreationDate = local.CreationDate
}