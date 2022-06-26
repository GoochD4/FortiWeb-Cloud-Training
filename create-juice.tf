

variable "generated_key_name" {
  type        = string
  default     = "terraform-key"
  description = "Key-pair generated by Terraform"
}

resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.generated_key_name
  public_key = tls_private_key.dev_key.public_key_openssh

  provisioner "local-exec" {    # Generate "terraform-key.pem" in current directory
    command = "echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.generated_key_name}'.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 ./'${var.generated_key_name}'.pem"
  }
}

resource "aws_instance" "juice-shop" {
  ami                    = "${data.aws_ami.awslinux.id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]
  subnet_id = aws_subnet.privatesubnetaz1.id
  associate_public_ip_address = false

  /* Specify SSH Key Name for login */
  key_name = "${var.generated_key_name}"
  /* Include Bash file and execute */
  user_data = <<EOF
  #!/bin/bash
  sleep 300
  echo "Updating server"
  yum update -y
  echo "Install and start docker"
  yum install -y docker
  service docker start
  echo "install and run juice-shop"
  docker pull bkimminich/juice-shop
  docker run -d -p 80:3000 bkimminich/juice-shop
  EOF

  tags = {
    Name = "juice-server"
  }
}
