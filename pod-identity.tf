data "aws_iam_policy_document" "external_secrets" {

  statement {

    sid = "ReadBackendSecrets"

    effect = "Allow"

    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]

    resources = [
      aws_secretsmanager_secret.backend.arn
    ]
  }
}

resource "aws_iam_policy" "external_secrets" {

  name = "${var.project_name}-external-secrets"

  description = "Allows reading backend secrets"

  policy = data.aws_iam_policy_document.external_secrets.json
}

data "aws_iam_policy_document" "pod_identity_trust" {

  statement {

    effect = "Allow"

    principals {

      type = "Service"

      identifiers = [
        "pods.eks.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "external_secrets" {

  name = "${var.project_name}-external-secrets-role"

  assume_role_policy = data.aws_iam_policy_document.pod_identity_trust.json
}

resource "aws_iam_role_policy_attachment" "external_secrets" {

  role = aws_iam_role.external_secrets.name

  policy_arn = aws_iam_policy.external_secrets.arn
}

resource "aws_eks_pod_identity_association" "external_secrets" {

  cluster_name = aws_eks_cluster.this.name

  namespace = "external-secrets"

  service_account = "external-secrets"

  role_arn = aws_iam_role.external_secrets.arn
}
