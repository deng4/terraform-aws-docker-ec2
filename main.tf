terraform {

  required_version = ">=1.9.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer"
  public_key = "${file("~/.ssh/terraform.pub")}"
}


module "my_ec2" {
  source              = "./modules/ec2"
  instance_type       = local.instance_type[terraform.workspace]
  subnet_id           = aws_subnet.docker_subnet.id
  security_groups_ids = aws_security_group.allow_ssh_http.id
  startup_script      = local.StartUpScriptDocker
  key_name            = "${aws_key_pair.deployer.key_name}"
  # TAGS SECTION

  Owner        = local.Owner
  Purpose      = local.Usage
  CreationDate = local.CreationDate
}

module "vpc" {
  source = "./modules/vpc"
}