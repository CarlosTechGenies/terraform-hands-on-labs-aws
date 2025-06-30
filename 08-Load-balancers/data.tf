# Data source for route 53

data "aws_route53_zone" "domain" {
  name = "carlos-aws-hands-on-labs.click"
}

# Data Source for ubuntu distro
data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "image-id"
    values = ["ami-0d1b5a8c13042c939"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

# Data Source for Amazon linux
data "aws_ami" "amazon_linux_ami" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "image-id"
    values = ["ami-0c803b171269e2d72"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}