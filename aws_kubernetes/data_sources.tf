data "aws_iam_role" "aws_k8s_eks_role" {
  name = "uber_ec2_eks"
}

data "aws_iam_role" "aws_k8s_nodegroup_role" {
  name = "AWSServiceRoleForAmazonEKSNodegroup"
}

data "aws_key_pair" "deployer" {
  key_name           = "deployer"
  include_public_key = true
}

data "aws_availability_zones" "available" {
  state = "available"
}
