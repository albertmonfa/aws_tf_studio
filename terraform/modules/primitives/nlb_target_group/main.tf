
resource "aws_lb_target_group" "app_nlb_tg" {
  name     = "${var.project_name}-tg-${var.environment}"
  vpc_id   = "${var.vpc}"

  target_type               = "${var.target_type}"
  deregistration_delay      = "${var.deregistration_delay}"
  port                      = "${var.port}"
  protocol                  = "${var.protocol}"

  health_check {
    interval = "${var.hc_interval}"
    protocol = "${var.protocol}"
    healthy_threshold = "${var.hc_healthy_threshold}"
    unhealthy_threshold = "${var.hc_unhealthy_threshold}"
  }

}
