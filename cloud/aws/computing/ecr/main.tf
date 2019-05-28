resource "aws_ecr_repository" "main" {
  name = "${var.ecr_name}"
}
