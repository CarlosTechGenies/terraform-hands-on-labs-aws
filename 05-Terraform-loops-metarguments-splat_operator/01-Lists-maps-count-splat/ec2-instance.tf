# EC2 Instance

resource "aws_instance" "dev-ohio-vm-list" {
  ami             = data.aws_ami.os-ami.id
  instance_type   = var.instance_type_list[1]
  key_name        = var.instance_keypair
  count           = length(var.instance_type_list)
  vpc_security_group_ids = [aws_security_group.dev-ohio-web-sg.id]
  tags = {
    Name       = "dev-ohio-vm-list-${count.index + 1}"
    Contact    = "Cposada"
    Department = "IT"
    Project    = "Terraform loops, metarguments and splat operator"
  }
}

resource "aws_instance" "dev-ohio-vm-map" {
  ami             = data.aws_ami.os-ami.id
  instance_type   = values(var.instance_type_map)[count.index]
  key_name        = var.instance_keypair
  count           = length(var.instance_type_map)
  vpc_security_group_ids = [aws_security_group.dev-ohio-web-sg.id]
  tags = {
    Name       = "dev-ohio-vm-map-${keys(var.instance_type_map)[count.index]}"
    Contact    = "Cposada"
    Department = "IT"
    Project    = "Terraform loops, metarguments and splat operator"
  }
}
