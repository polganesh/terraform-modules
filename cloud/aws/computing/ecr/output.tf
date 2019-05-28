output "arn" {
  value = "${aws_ecr_repository.main.arn}"
}

output "name" {
  value = "${aws_ecr_repository.main.name}"
}

output "registry_id" {
  value = "${aws_ecr_repository.main.registry_id}"
}

output "repository_url" {
  value = "${aws_ecr_repository.main.repository_url}"
}
