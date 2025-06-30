#Security group classic load balancer
module "clb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name        = "${var.prefix}-clb-sg"
  description = "Allow Http connectin from internet to AWS network"
  vpc_id      = var.vpc_id
  tags        = var.common_tags

  #Ingress rules
  ingress_with_cidr_blocks = [
    #form 1
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow traffic from internet through port 80"
    },
    #form 2
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow traffic from internet through port 81"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  #Egress rules
  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow traffic from aws networtk to internet"
    }
  ]
} 