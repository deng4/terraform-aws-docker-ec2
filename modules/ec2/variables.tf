
variable "subnet_id" {}
variable "security_groups_ids" {}
variable "startup_script" {}
variable "instance_type" {}
variable "key_name" {}


# TAGS SECTION

variable "Purpose" {}
variable "Owner" {}
variable "CreationDate" {}

locals {
    StartUpScriptDocker = file("./docker_install.sh")
}
