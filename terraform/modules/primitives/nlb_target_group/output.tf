output "id" {
  value = "${aws_lb_target_group.app_nlb_tg.id}"
}

output "arn" {
  value = "${aws_lb_target_group.app_nlb_tg.arn}"
}

output "arn_suffix" {
  value = "${aws_lb_target_group.app_nlb_tg.arn_suffix}"
}

output "name" {
  value = "${aws_lb_target_group.app_nlb_tg.name}"
}
