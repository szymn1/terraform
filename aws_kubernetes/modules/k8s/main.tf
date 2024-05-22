resource "aws_eks_cluster" "aws_k8s_cluster" {
  name     = var.cluster_name
  role_arn = var.role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "aws_k8s_node_group" {
  cluster_name    = aws_eks_cluster.aws_k8s_cluster.name
  node_group_name = "${aws_eks_cluster.aws_k8s_cluster.name}_node_group"
  node_role_arn   = var.role.arn
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
    desired_size = var.node_group_scaling.desired_size
    max_size     = var.node_group_scaling.max_size
    min_size     = var.node_group_scaling.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }
}
