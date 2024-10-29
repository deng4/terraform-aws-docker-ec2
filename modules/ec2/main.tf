resource "aws_key_pair" "deployer" {
  public_key = "${file("/home/$USER/.ssh/terraform.pub")}" 
}

resource "aws_instance" "myec2" {
  ami                         = data.aws_ami.my_image.image_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.deployer.public_key
  startup_script              = "${file("./docker_install.sh")}"
  associate_public_ip_address = "true" ### ALLOWS TO CREATE ELASTIC IP TO ATTACH TO VM
  private_dns_name_options {
    enable_resource_name_dns_a_record = "true"
  }
  vpc_security_group_ids = [ var.security_groups_ids ]
  subnet_id              = var.subnet_id
  user_data              = var.startup_script

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }

  tags = {
    Name         = "MyDockerEC2"
    Purpose      = var.Purpose
    Owner        = var.Owner
    CreationDate = var.CreationDate
  }

    lifecycle {
    create_before_destroy = true
    ignore_changes = [ tags["CreationDate"], private_dns_name_options, associate_public_ip_address ]
  }
}




