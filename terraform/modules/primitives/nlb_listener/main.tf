resource "aws_lb_listener" "app_nlb_listener" {
  load_balancer_arn = "${var.nlb_arn}"
  port              = "${var.port}"
  protocol          = "TCP"

  default_action {
    target_group_arn = "${var.nlb_tg_arn}"
    type             = "forward"
  }
}
