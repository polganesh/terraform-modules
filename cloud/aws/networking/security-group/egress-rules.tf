resource "aws_security_group_rule" "egress_cidr_rule" {
  count             = "${length(var.outbound_cidr_rules)}"
  type              = "egress"
  cidr_blocks       = ["${element(var.outbound_cidr_rules[count.index], 0)}"]
  from_port         = "${element(var.outbound_cidr_rules[count.index], 1)}"
  to_port           = "${element(var.outbound_cidr_rules[count.index], 2)}"
  protocol          = "${element(var.outbound_cidr_rules[count.index], 3)}"
  security_group_id = "${aws_security_group.securitygroup.id}"
}

resource "aws_security_group_rule" "egress_id_rule" {
  count                          = "${length(var.outbound_id_rules)}"
  type                           = "egress"
  source_security_group_id       = "${element(var.outbound_id_rules[count.index], 0)}"
  from_port                      = "${element(var.outbound_id_rules[count.index], 1)}"
  to_port                        = "${element(var.outbound_id_rules[count.index], 2)}"
  protocol                       = "${element(var.outbound_id_rules[count.index], 3)}"
  security_group_id              = "${aws_security_group.securitygroup.id}"
}