resource "aws_security_group_rule" "ingress_cidr_rule" {
  count             = "${length(var.inbound_cidr_rules)}"
  type              = "ingress"
  cidr_blocks       = ["${element(var.inbound_cidr_rules[count.index], 0)}"]
  from_port         = "${element(var.inbound_cidr_rules[count.index], 1)}"
  to_port           = "${element(var.inbound_cidr_rules[count.index], 2)}"
  protocol          = "${element(var.inbound_cidr_rules[count.index], 3)}"
  security_group_id = "${aws_security_group.securitygroup.id}"
}

resource "aws_security_group_rule" "ingress_id_rule" {
  count                    = "${length(var.inbound_id_rules)}"
  type                     = "ingress"
  source_security_group_id = "${element(var.inbound_id_rules[count.index], 0)}"
  from_port                = "${element(var.inbound_id_rules[count.index], 1)}"
  to_port                  = "${element(var.inbound_id_rules[count.index], 2)}"
  protocol                 = "${element(var.inbound_id_rules[count.index], 3)}"
  security_group_id        = "${aws_security_group.securitygroup.id}"
}
