resource "aws_vpc" "aws_k8s_vpc" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "aws_k8s"
  }
}

resource "aws_subnet" "aws_k8s_cluster_net_1a" {
  vpc_id            = aws_vpc.aws_k8s_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr["p0"], 8, 0)
  availability_zone = "eu-north-1a"

  tags = {
    Name = "aws_k8s"
  }
}

resource "aws_subnet" "aws_k8s_cluster_net_1b" {
  vpc_id            = aws_vpc.aws_k8s_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr["p0"], 8, 1)
  availability_zone = "eu-north-1b"

  tags = {
    Name = "aws_k8s"
  }
}

# resource "aws_security_group" "aws_k8s_security_group" {
#   name        = "aws_k8s_security_group"
#   description = "Cluster communication with worker nodes"
#   vpc_id      = aws_vpc.aws_k8s_vpc.id

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "aws_k8s_security_group"
#   }
# }

# resource "aws_security_group_rule" "aws_k8s_ingress_workstation_https" {
#   cidr_blocks       = [local.workstation-external-cidr]
#   description       = "Allow workstation to communicate with the cluster API Server"
#   from_port         = 443
#   protocol          = "tcp"
#   security_group_id = aws_security_group.aws_k8s_security_group.id
#   to_port           = 443
#   type              = "ingress"
# }

resource "aws_eks_cluster" "aws_k8s_cluster" {
  name     = "aws_k8s_cluster"
  role_arn = data.aws_iam_role.aws_k8s_eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.aws_k8s_cluster_net_1a.id, aws_subnet.aws_k8s_cluster_net_1b.id]
  }
}

resource "aws_eks_node_group" "aws_k8s_node_group" {
  cluster_name    = aws_eks_cluster.aws_k8s_cluster.name
  node_group_name = "aws_k8s_node_group"
  node_role_arn   = data.aws_iam_role.aws_k8s_eks_role.arn
  subnet_ids      = aws_eks_cluster.aws_k8s_cluster.vpc_config[0].subnet_ids
  instance_types  = ["t3.micro"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}
