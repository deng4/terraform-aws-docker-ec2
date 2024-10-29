variable "subnet_cidr" {
  type    = string
  default = "10.10.0.0/24"
}

variable "allow_all" {
  type    = string
  default = "0.0.0.0/0"
}

variable "my_ip" {}

variable "deployer_user" {
  
}

variable "environment" {
  type    = string
  default = "default"
}

variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80, 8080, 9000]
}