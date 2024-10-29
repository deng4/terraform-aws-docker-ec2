This module is for learning purposes only! Do not use on PROD.
As a result you gonna get a wokring EC2 with ssh key copied to AWS key pairs.

Prereqs:
add this to your .bashrc in order to run everything seamless

```bash

export TF_VAR_my_ip=$(wget -q -O - ipinfo.io/ip)
export TF_VAR_deployer_user=$USER

```


```hcl

terraform {

}

provider "aws" {
  region = "us-east-1"
}

module "my_ec2" {
  source              = "./modules/ec2"
  instance_type       = local.instance_type[terraform.workspace] # depends on environment
  subnet_id           = aws_subnet.docker_subnet.id # or use you existing one
  security_groups_ids = aws_security_group.allow_ssh_http.id # or use you existing one
  startup_script      = local.StartUpScriptDocker # feel free to modify this part as well
  key_name            = "${aws_key_pair.deployer.key_name}" # use ssh-keygen to genereate keypare with terraform terraform.pub files in ~/.ssh/ folder
  # TAGS SECTION

  Owner        = local.Owner
  Purpose      = local.Usage
  CreationDate = local.CreationDate
}
```