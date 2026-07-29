resource "aws_secretsmanager_secret" "backend" {

  name = "${var.project_name}/backend-secret"

  description = "Secrets for StudyHub backend"

  tags = {
    Name = "${var.project_name}-backend-secret"
  }
}
