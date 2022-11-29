resource "aws_vpc" "training" {
  cidr_block       = "172.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "training"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.training.id

  tags = {
    Name = "training_gateway"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.training.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_subnet" "training_autoscaling" {
  vpc_id     = aws_vpc.training.id
  cidr_block = "172.16.1.0/24"

  tags = {
    Name = "training_autoscaling"
  }
}

resource "aws_subnet" "training_db" {
  vpc_id     = aws_vpc.training.id
  cidr_block = "172.16.2.0/24"

  tags = {
    Name = "training_db"
  }
}

module "autoscaling" {
  source = "./modules/autoscaling"

  vpc_id          = data.aws_vpc.training.id
  subnet_id       = aws_subnet.training_autoscaling.id
  image_id        = var.image_id
  vm_type         = var.vm_type
  autoscaling_azs = var.autoscaling_azs
  user_ip         = var.user_ip
  public_key      = var.public_key
}
