# Module for alb base on host header routing

module "alb_host_header" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  load_balancer_type = "application"
  name               = "${var.prefix}-hh-alb"
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
        b2b-path = {
          priority = 11
          actions = [
            {
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
            }
          ]
          conditions = [
            {
              host_header = {
                values = ["${var.api}"]
              },
              path_pattern = {
                values = ["/b2b*"]
              }
            }
          ]
        },
        b2c-path = {
          priority = 12
          actions = [
            {
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
            }
          ]
          conditions = [
            {
              host_header = {
                values = ["${var.web}"]
              },
              path_pattern = {
                values = ["/b2c*"]
              }
            }
          ]
        },
        host_header_api = {
          priority = 1
          actions = [{
            type             = "forward"
            target_group_key = "tg1"
          }]
          conditions = [
            {
              host_header = {
                values = ["${var.api}"]
              }
            }
          ]
        },
        host_header_web = {
          priority = 2
          actions = [
            {
              type             = "forward"
              target_group_key = "tg2"
            }
          ]
          conditions = [
            {
              host_header = {
                values = ["${var.web}"]
              }
            }
          ]
        },
        custom_header_rule = {
          priority = 3
          actions = [
            {
              type             = "forward"
              target_group_key = "tg2"
            }
          ]
          stickiness = {
            enabled  = true
            duration = 3600
          }
          conditions = [
            {
              http_header = {
                http_header_name = "custom-header"
                values           = ["testing", "stg", "staging"]
              }
            }
          ]
        },
        redirect_hh = {
          priority = 14
          actions = [
            {
              type        = "redirect"
              status_code = "HTTP_302"
              host        = "techgenies.com"
              path        = "/cloud-infrastructure-services/"
              query       = ""
              protocol    = "HTTPS"
            }
          ]
          conditions = [
            {
              host_header = {
                values = ["apps.carlos-aws-hands-on-labs.click"]
              }
            }
          ]
        },
        redirect-query = {
          priority = 13
          actions = [{
            type        = "redirect"
            status_code = "HTTP_302"
            host        = "techgenies.com"
            path        = "/data-artificial-intelligence/"
            query       = ""
            protocol    = "HTTPS"
          }]

          conditions = [{
            host_header = {
                values = ["apps.carlos-aws-hands-on-labs.click"]
              },
            query_string = {
              key   = "service"
              value = "data-artificial-intelligence"
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
  target_group_arn = module.alb_host_header.target_groups["tg1"].arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb_target_group_attachment" "instance_attachment_tg2" {
  for_each         = { for i, id in var.ec2_private_b2c_ids : i => id }
  target_group_arn = module.alb_host_header.target_groups["tg2"].arn
  target_id        = each.value
  port             = 80
}