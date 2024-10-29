
locals {
  Prefix              = ""
  Usage               = ""
  Owner               = ""
  CreationDate        = "date-${formatdate("DDMMMYYYY", timestamp())}"
  StartUpScriptDocker = file("./docker_install.sh")

  instance_type = {
    default = "t2.micro"
    dev     = "t2.medium"
    prod    = "t3a.medium"
  }
}
