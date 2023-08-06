resource "aws_route53_zone" "my_domain" {
  name = var.DOMAIN_NAME
}

resource "aws_route53_record" "domain_record_A_1" {
  zone_id = aws_route53_zone.my_domain.zone_id
  name    = var.DOMAIN_NAME
  type    = "A"
  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "domain_record_A_2" {
  zone_id = aws_route53_zone.my_domain.zone_id
  name    = var.WWW_DOMAIN_NAME
  type    = "A"
  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
