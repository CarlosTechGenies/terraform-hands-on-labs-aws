# security group for the public instance
resource "aws_security_group" "dev-ohio-web-sg" {
  name        = "dev-ohio-web-sg"
  description = "Security group for public instances with SSH, HTTP, HTTPS access"

  tags = {
    Name    = "Public instance SG"
    Contact = "Cposada"
    Project = "Dev-ohio"
  }
}

# Ingress Rule: Allow SSH (Port 22) from your specific IP
resource "aws_vpc_security_group_ingress_rule" "ssh_from_my_ip" {
  security_group_id = aws_security_group.dev-ohio-web-sg.id
  description       = "Allow SSH from my specific IP"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.my_ip
}

# Ingress Rule: Allow HTTP (Port 80) from anywhere (IPv4)
resource "aws_vpc_security_group_ingress_rule" "http_anywhere_ipv4" {
  security_group_id = aws_security_group.dev-ohio-web-sg.id
  description       = "Allow HTTP from anywhere (IPv4)"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

# Ingress Rule: Allow HTTPS (Port 443) from anywhere (IPv4)
resource "aws_vpc_security_group_ingress_rule" "https_anywhere_ipv4" {
  security_group_id = aws_security_group.dev-ohio-web-sg.id
  description       = "Allow HTTPS from anywhere (IPv4)"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

# Egress Rule: Allow all outbound traffic (default for new security groups, but good to be explicit)
resource "aws_vpc_security_group_egress_rule" "allow_all_outbound_ipv4" {
  security_group_id = aws_security_group.dev-ohio-web-sg.id
  description       = "Allow all outbound traffic (IPv4)"
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1" # -1 means all protocols
  cidr_ipv4         = "0.0.0.0/0"
}
