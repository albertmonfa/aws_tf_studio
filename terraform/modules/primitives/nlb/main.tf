
resource "aws_lb" "app_nlb" {
  name                          = "${var.project_name}-nlb-${var.environment}"
  subnets                       = "${var.subnets}"
  internal                      = "${var.internal}"
  enable_deletion_protection    = "${var.enable_deletion_protection}"
  load_balancer_type            = "network"
  idle_timeout                  = "${var.enable_deletion_protection}"
}
