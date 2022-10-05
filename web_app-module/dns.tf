# route53 to run web application on a domain

# resource "aws_route53_zone" "primary" {
#   count = var.create_dns_zone
#   name  = "clxdevopsdeployed.com"
# }

# resource "aws_route53_record" "root" {
#   zone_id = aws_route53_zone.primary.zone_id
#   name    = "clxdevopsdeployed.com"
#   type    = "A"

#   alias {
#     name                   = aws_lb.load_balancer.dns_name
#     zone_id                = aws_lb.load_balancer.zone_id
#     evaluate_target_health = true
#   }
# }