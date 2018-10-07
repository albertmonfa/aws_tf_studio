resource "aws_network_acl" "nacl" {
  subnet_ids  = ["${var.subnet_ids}"]
  vpc_id      = "${var.vpc_id}"
  tags             = "${merge(
                               var.tags, map("Name", format("%s-nacl", var.name)),
                               var.tags, map("Z_name", format("%s-nacl", var.name)),
                               var.tags, map("Z_type", "NetworkACL")
                             )}"
}

resource "aws_network_acl_rule" "nacl_igress" {
  network_acl_id = "${aws_network_acl.nacl.id}"
  count             = "${length(var.inbound_rules)}"
  egress         = false
  rule_number    = "${element(var.inbound_rules[count.index], 0)}"
  protocol       = "${element(var.inbound_rules[count.index], 1)}"
  rule_action    = "${element(var.inbound_rules[count.index], 2)}"
  cidr_block     = "${element(var.inbound_rules[count.index], 3)}"
  from_port      = "${element(var.inbound_rules[count.index], 4)}"
  to_port        = "${element(var.inbound_rules[count.index], 5)}"
}

resource "aws_network_acl_rule" "nacl_egress" {
  network_acl_id = "${aws_network_acl.nacl.id}"
  count             = "${length(var.outbound_rules)}"
  egress         = true
  rule_number    = "${element(var.outbound_rules[count.index], 0)}"
  protocol       = "${element(var.outbound_rules[count.index], 1)}"
  rule_action    = "${element(var.outbound_rules[count.index], 2)}"
  cidr_block     = "${element(var.outbound_rules[count.index], 3)}"
  from_port      = "${element(var.outbound_rules[count.index], 4)}"
  to_port        = "${element(var.outbound_rules[count.index], 5)}"
}
