resource "aws_acm_certificate" "ssl_certificate" {
  domain_name               = var.WILDCARD_DOMAIN_NAME
  subject_alternative_names = [var.DOMAIN_NAME]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

// Adding CNAME  provided by ACM to the hosted zone
resource "aws_route53_record" "cname_acm" {
  for_each = {
    for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.my_domain.zone_id
}

// Validating the ACM
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.ssl_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cname_acm : record.fqdn]
}