data "aws_route53_zone" "main" {
  name = var.host_zone_name
}

resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.record_name
  type    = "A"
  ttl     = "300"
  records = [aws_eip.main.public_ip]
}
