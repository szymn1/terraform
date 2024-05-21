locals {
  subnets = {
    for i, v in data.aws_availability_zones.available.names :
    "aws_k8s_cluster_net_${i + 1}" =>
    {
      cidr = cidrsubnet(var.vpc_cidr["p0"], 8, i)
      az   = v
    }
  }
}

resource "aws_subnet" "cluster_net" {
  for_each = local.subnets

  vpc_id            = aws_vpc.aws_k8s_vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "aws_k8s_public_subnet" {
  vpc_id            = aws_vpc.aws_k8s_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr["p0"], 8, 255)
  availability_zone = "eu-north-1a"

  tags = {
    Name = "aws_k8s_public_net"
  }
}

resource "aws_eip" "public_ip" {
  tags = {
    Name = "aws_k8s"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_k8s_vpc.id

  tags = {
    Name = "aws_k8s"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.public_ip.id
  subnet_id     = aws_subnet.aws_k8s_public_subnet.id

  tags = {
    Name = "aws_k8s"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.aws_k8s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "aws_k8s_igw"
  }
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.aws_k8s_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "aws_k8s_nat"
  }
}

resource "aws_route_table_association" "internet" {
  subnet_id      = aws_subnet.aws_k8s_public_subnet.id
  route_table_id = aws_route_table.igw.id
}

resource "aws_route_table_association" "cluster_nat" {
  for_each       = aws_subnet.cluster_net
  subnet_id      = each.value.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_security_group" "aws_k8s_external_access_security_group" {
  name        = "aws_k8s_external_access_security_group"
  description = "Communication with worker nodes from local machine"
  vpc_id      = aws_vpc.aws_k8s_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws_k8s"
  }
}

resource "aws_security_group_rule" "aws_k8s_ingress_workstation_https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "Communication with worker nodes from local machine"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.aws_k8s_external_access_security_group.id
  to_port           = 443
  type              = "ingress"
}
