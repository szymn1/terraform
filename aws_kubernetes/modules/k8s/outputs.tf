output "endpoint" {
  value = aws_eks_cluster.aws_k8s_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.aws_k8s_cluster.certificate_authority[0].data
}
