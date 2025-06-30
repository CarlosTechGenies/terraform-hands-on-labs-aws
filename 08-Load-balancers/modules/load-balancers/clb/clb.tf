#clb module
module "clb" {
  source          = "terraform-aws-modules/elb/aws"
  version         = "4.0.2"
  name            = "${var.prefix}-clb"
  subnets         = var.public_subnets_ids
  security_groups = [var.clb_sg_id]
  tags            = var.common_tags

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 81
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  // ELB attachments
  number_of_instances = var.private_instance_count
  instances           = var.ec2_private_ids
}