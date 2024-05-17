resource "aws_eks_cluster" "aws_k8s_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.aws_k8s.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  depends_on = [aws_iam_role.aws_k8s]
}

resource "aws_eks_node_group" "aws_k8s_node_group" {
  cluster_name    = aws_eks_cluster.aws_k8s_cluster.name
  node_group_name = "aws_k8s_node_group"
  node_role_arn   = aws_iam_role.aws_k8s.arn
  subnet_ids      = aws_eks_cluster.aws_k8s_cluster.vpc_config[0].subnet_ids
  instance_types  = var.instance_types
  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
    source_security_group_ids = [
      var.source_security_group_id,
      aws_eks_cluster.aws_k8s_cluster.vpc_config[0].cluster_security_group_id
    ]
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}
