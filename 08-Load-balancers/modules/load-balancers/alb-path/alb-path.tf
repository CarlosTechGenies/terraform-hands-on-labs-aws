# Module for alb base on path routing

module "alb_path" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  load_balancer_type = "application"
  name               = "${var.prefix}-path-alb"
  vpc_id             = var.vpc_id
  subnets            = var.public_subnets_ids
  security_groups    = [var.alb_sg_id]
  #this field is for purpose of this hands-on, in real project this must be in true
  enable_deletion_protection = false
  tags                       = var.common_tags

  #listeners
  listeners = {
    http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    },

    https = {
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn = var.acm_certificate_arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "404, lost way"
        status_code  = "404"
      }

      rules = {
        b2b-responce = {
          priority = 1
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "tg1"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/b2b*"]
            }
          }]
        },

        b2c-response = {
          priority = 2
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "tg2"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/b2c*"]
            }
          }]
        }
      }
    }
  }

  #Target groups
  target_groups = {
    tg1 = {
      create_attachment                 = false
      name                              = "${var.prefix}-b2b-tg"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = true

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
        path                = "/b2b/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      tags             = var.common_tags
    },
    tg2 = {
      create_attachment                 = false
      name                              = "${var.prefix}-b2c-tg"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = true

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
        path                = "/b2c/index.html"
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

resource "aws_lb_target_group_attachment" "instance_attachment_tg1" {
  for_each         = { for i, id in var.ec2_private_b2b_ids : i => id }
  target_group_arn = module.alb_path.target_groups["tg1"].arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb_target_group_attachment" "instance_attachment_tg2" {
  for_each         = { for i, id in var.ec2_private_b2c_ids : i => id }
  target_group_arn = module.alb_path.target_groups["tg2"].arn
  target_id        = each.value
  port             = 80
}