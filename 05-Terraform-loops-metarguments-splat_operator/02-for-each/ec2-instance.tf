# Available zones
data "aws_availability_zones" "az" {
  all_availability_zones = true
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# EC2 Instance
resource "aws_instance" "dev-ohio-vm-map" {
  ami                    = data.aws_ami.os-ami.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.dev-ohio-web-sg.id]
  for_each               = toset(data.aws_availability_zones.az.names)
  availability_zone      = each.key
  tags = {
    Name       = "dev-ohio-vm-map-${each.value}"
    Contact    = "Cposada"
    Department = "IT"
    Project    = "Terraform loops, metarguments and splat operator"
  }
}
