data "aws_ami" "my_image" {
  most_recent = "true"
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"]
  }
}