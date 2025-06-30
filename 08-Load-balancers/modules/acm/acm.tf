# ACM Module - To create and Verify SSL Certificates
module "acm" {
  source = "terraform-aws-modules/acm/aws"
  #version = "2.14.0"
  version = "5.0.0"

  domain_name = trimsuffix(var.domain_name, ".")
  zone_id     = var.zone_id

  subject_alternative_names = [
    "*.${var.domain_name}"
  ]
  tags = var.common_tags

  # Validation Method
  validation_method   = "DNS"
  wait_for_validation = true
}

