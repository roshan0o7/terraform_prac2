resource "aws_instance" "bastion" {
  ami           = "ami-0c55b159cbfafe1f0" # Update with your preferred AMI
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  security_groups = [var.bastion_sg_id]

  root_block_device {
    volume_size = 10
  }
}

resource "aws_instance" "private" {
  ami           = "ami-0c55b159cbfafe1f0" # Update with your preferred AMI
  instance_type = "t2.micro"
  subnet_id     = var.private_subnet_id
  security_groups = [var.private_sg_id]

  root_block_device {
    volume_size = 25
  }
}
