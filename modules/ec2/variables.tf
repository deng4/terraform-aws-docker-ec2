# TAGS SECTION

variable "Purpose" {}
variable "Owner" {}
variable "CreationDate" {}

# NETWORK VARIABLES

variable "subnet_id" {}
variable "security_groups_ids" {}
variable "startup_script" {}
variable "instance_type" {}
variable "my_ip" {} #must be determined with: EXPORT TF_VAR_my_ip=$(wget -q -O - ipinfo.io/ip)
variable "vpc_cidr" {
  type = string
  default = "10.1.0.0/16"
}
variable "subnet_cidr" {
    type = string
    default = "10.1.0.0/24"
}
variable "allow_all" {
    type= string
    default = "0.0.0.0/0"
}
variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80, 8080, 9000]
}
