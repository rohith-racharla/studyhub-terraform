resource "aws_secretsmanager_secret" "backend" {

  name = "${var.project_name}/backendsecret"

  description = "Secrets for StudyHub backend"

  recovery_window_in_days = 7

  tags = {
    Name = "${var.project_name}-backend-secret"
  }
}
