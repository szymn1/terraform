resource "aws_iam_role" "aws_k8s" {
  name = "aws_k8s"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = [
            "eks-nodegroup.amazonaws.com",
            "ec2.amazonaws.com",
            "eks.amazonaws.com"
          ]
        }
      }
    ]
  })

  inline_policy {
    name = "uber_policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "",
          Effect = "Allow",
          Action = [
            "iam:ListAttachedRolePolicies",
            "ec2:*",
            "eks:*",
            "eks-auth:*"
          ],
          Resource = "*"
        },
        {
          Sid    = "",
          Effect = "Allow",
          Action = [
            "route53:AssociateVPCWithHostedZone"
          ],
          Resource = "arn:aws:route53:::hostedzone/*"
        }
      ]
    })
  }

  tags = {
    Name = "aws_k8s"
  }
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.aws_k8s.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  role       = aws_iam_role.aws_k8s.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.aws_k8s.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
