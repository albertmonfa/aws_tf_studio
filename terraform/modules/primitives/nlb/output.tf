output "id" {
  value = "${aws_lb.app_nlb.id}"
}

output "arn" {
  value = "${aws_lb.app_nlb.arn}"
}

output "arn_suffix" {
  value = "${aws_lb.app_nlb.arn_suffix}"
}

output "dns_name" {
  value = "${aws_lb.app_nlb.dns_name}"
}

output "zone_id" {
  value = "${aws_lb.app_nlb.zone_id}"
}
