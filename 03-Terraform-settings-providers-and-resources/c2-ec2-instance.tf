#EC2 Instance
resource "aws_instance" "dev-ohio-vm-1" {
  ami           = "ami-04f167a56786e4b09"
  instance_type = "t2.micro"
  key_name      = "dev-ohio-learning-kp"
  user_data     = file("${path.module}/user-data.sh")
  tags = {
    Name       = "dev-ohio-vm-1"
    Contact    = "Cposada"
    Department = "IT"
    Project    = "Terraform hands on labs"
  }
}