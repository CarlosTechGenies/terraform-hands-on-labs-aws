# Module for alb basic

module "alb_without_asg" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  load_balancer_type = "application"
  name               = "${var.prefix}-basic-alb"
  vpc_id             = var.vpc_id
  subnets            = var.public_subnets_ids
  security_groups    = [var.alb_sg_id]
  #this field is for purpose of this hands-on, in real project this must be in true
  enable_deletion_protection = false
  tags                       = var.common_tags

  #listeners
  listeners = {
    http-listener = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "tg1"
      }
    }
  }

  #Target groups
  target_groups = {
    tg1 = {
      create_attachment                 = false
      name                              = "${var.prefix}-tg1"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = false

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      tags             = var.common_tags
    }
  }
}

resource "aws_lb_target_group_attachment" "instance_attachment" {
  for_each         = { for i, id in var.ec2_private_ids : i => id }
  target_group_arn = module.alb_without_asg.target_groups["tg1"].arn
  target_id        = each.value
  port             = 80
}