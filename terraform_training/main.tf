resource "aws_vpc" "training" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "training"
  }
}

resource "aws_subnet" "training_public" {
  vpc_id     = aws_vpc.training.id
  cidr_block = cidrsubnet(var.network-cidr["p0"], 8, 0)

  tags = {
    Name = "training_nat_gw"
  }
}

resource "aws_subnet" "training_autoscaling" {
  vpc_id     = aws_vpc.training.id
  cidr_block = cidrsubnet(var.network-cidr["p0"], 8, 1)

  tags = {
    Name = "training_autoscaling"
  }
}

resource "aws_subnet" "training_db" {
  vpc_id            = aws_vpc.training.id
  cidr_block        = cidrsubnet(var.network-cidr["p0"], 8, 2)
  availability_zone = "us-east-2a"

  tags = {
    Name = "training_db1"
  }
}

resource "aws_subnet" "training_db2" {
  vpc_id            = aws_vpc.training.id
  cidr_block        = cidrsubnet(var.network-cidr["p0"], 8, 4)
  availability_zone = "us-east-2b"

  tags = {
    Name = "training_db2"
  }
}

resource "aws_eip" "public_ip" {
  vpc = true
  tags = {
    Name = "training_public_ip_nat_gw"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.training.id

  tags = {
    Name = "training_gateway"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.public_ip.id
  subnet_id     = aws_subnet.training_public.id

  tags = {
    Name = "training_nat"
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "igw" {
  vpc_id = aws_vpc.training.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "training_igw_route"
  }
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.training.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "training_nat_route"
  }
}

resource "aws_route_table_association" "autoscaling" {
  subnet_id      = aws_subnet.training_autoscaling.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "internet" {
  subnet_id      = aws_subnet.training_public.id
  route_table_id = aws_route_table.igw.id
}

module "autoscaling" {
  source = "./modules/autoscaling"

  vpc_id          = data.aws_vpc.training.id
  subnet_id       = aws_subnet.training_autoscaling.id
  pub_subnet_id   = aws_subnet.training_public.id
  image_id        = var.image_id
  vm_type         = var.vm_type
  autoscaling_azs = var.autoscaling_azs
  user_ip         = var.user_ip
  public_key = {
    name    = "AWS labs TEST key"
    content = var.public_key
  }
}

module "databases" {
  source = "./modules/databases"

  vpc_id     = data.aws_vpc.training.id
  subnet_ids = [aws_subnet.training_db.id, aws_subnet.training_db2.id]
  user_ip    = var.user_ip
  db_user    = var.db_user
  db_pass    = var.db_pass
}
