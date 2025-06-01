# EC2 Instance

resource "aws_instance" "dev-ohio-vm-1" {
  ami                    = data.aws_ami.os-ami.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  user_data              = file("${path.module}/user-data.sh")
  vpc_security_group_ids = [aws_security_group.dev-ohio-web-sg.id]
  tags = {
    Name       = "dev-ohio-vm-1"
    Contact    = "Cposada"
    Department = "IT"
    Project    = "Terraform hands on labs"
  }
}