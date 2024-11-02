
resource "cloudflare_record" "example_com_ns" {
  count   = length(var.private_dns_zone)
  zone_id = var.cloudflare_zone
  name    = "${var.name}"
  type    = "NS"
  value   = var.private_dns_zone[count.index]
}