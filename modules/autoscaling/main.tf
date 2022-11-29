resource "aws_launch_template" "test_launch_template" {
  name_prefix   = "TEST"
  image_id      = var.image_id
  instance_type = var.vm_type
  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      volume_size           = 8
      volume_type           = "gp3"
    }
  }
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.http_and_this_pc_ssh.id]
}

resource "aws_autoscaling_group" "test_autoscaling_group" {
  vpc_zone_identifier = [var.subnet_id]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  target_group_arns   = [aws_lb_target_group.test.arn]

  launch_template {
    id      = aws_launch_template.test_launch_template.id
    version = "$Latest"
  }
}

resource "aws_lb" "test" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [var.subnet_id] #data.aws_subnets.example.ids
}

resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }
}

resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id #data.aws_vpc.selected.id
  health_check {
    enabled = true
  }
}

resource "aws_security_group" "http_and_this_pc_ssh" {
  name   = "AWS labs TEST"
  vpc_id = var.vpc_id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from this PC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.user_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "AWS labs TEST key"
  public_key = var.public_key
}