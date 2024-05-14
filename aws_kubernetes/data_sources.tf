data "aws_iam_role" "aws_k8s_eks_role" {
  name = "uber_ec2_eks"
}

data "aws_iam_role" "aws_k8s_nodegroup_role" {
  name = "AWSServiceRoleForAmazonEKSNodegroup"
}
