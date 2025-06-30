module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${var.prefix}-private-sg"
  description = "Security group with HTTP & SSH ports ope for entire VPC block(IPV4)"
  vpc_id      = var.vpc_id

  # Ingress Rules & CIDR Blocks
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = var.vpc_cidr_block
      description = "Allow SSH access from any resource within the VPC"
    },
    {
      rule        = "http-80-tcp"
      cidr_blocks = var.vpc_cidr_block
      description = "Allow HTTP access from any resource within the VPC"
    }
  ]

  # Egress Rules
  egress_rules = ["all-all"]
  tags         = var.common_tags
} 