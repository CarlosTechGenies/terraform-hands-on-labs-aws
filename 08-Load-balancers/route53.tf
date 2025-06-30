resource "aws_route53_record" "apps_dns" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "apps.${data.aws_route53_zone.domain.name}"
  type    = "A"
  alias {
    name                   = module.alb_host_header_routing.dns_name
    zone_id                = module.alb_host_header_routing.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "api" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "api.${data.aws_route53_zone.domain.name}"
  type    = "A"
  alias {
    name                   = module.alb_host_header_routing.dns_name
    zone_id                = module.alb_host_header_routing.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "web" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "web.${data.aws_route53_zone.domain.name}"
  type    = "A"
  alias {
    name                   = module.alb_host_header_routing.dns_name
    zone_id                = module.alb_host_header_routing.zone_id
    evaluate_target_health = true
  }
}