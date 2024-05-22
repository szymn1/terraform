resource "aws_vpc" "aws_k8s_vpc" {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "aws_k8s"
  }
}

module "k8s" {
  source = "./modules/k8s"

  cluster_name             = "aws_k8s_cluster"
  role                     = aws_iam_role.aws_k8s
  subnet_ids               = [for i in aws_subnet.cluster_net : i.id]
  ec2_ssh_key              = data.aws_key_pair.deployer.key_name
  source_security_group_id = aws_security_group.aws_k8s_external_access_security_group.id
}
