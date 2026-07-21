resource "aws_eks_node_group" "this" {
  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${var.project_name}-node-group"

  node_role_arn = aws_iam_role.eks_node.arn

  subnet_ids = module.vpc.private_subnets

  instance_types = [var.node_instance_type]

  update_config {
    max_unavailable = 1
  }

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 3
  }

  disk_size = 20

  capacity_type = "ON_DEMAND"

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.ecr_read_only,
    aws_iam_role_policy_attachment.eks_cni_policy,
  ]

  tags = {
    Name = "${var.project_name}-node-group"
  }
}
