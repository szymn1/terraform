output "db_access" {
  value = aws_db_instance.default.endpoint
}

resource "aws_security_group" "DB_access" {
  name   = "AWS labs DB"
  vpc_id = var.vpc_id
  ingress {
    description = "DB access"
    from_port   = 5432
    to_port     = 5432
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

resource "aws_db_parameter_group" "example" {
  name   = "my-pg"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "db" {
  name       = "db"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_name                = "postgres"
  engine                 = "postgres"
  instance_class         = "db.t4g.micro"
  username               = var.db_user
  password               = var.db_user
  parameter_group_name   = aws_db_parameter_group.example.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.DB_access.id]
  db_subnet_group_name   = aws_db_subnet_group.db.name
}



resource "aws_route53_zone" "db" {
  name = "my.test"
}

resource "aws_route53_record" "db" {
  zone_id = aws_route53_zone.db.zone_id
  name    = "database.my.test"
  type    = "CNAME"
  ttl     = "180"
  records = [aws_db_instance.default.address]
}

resource "aws_sns_topic" "db_alerts" {
  name = "db-alerts-topic"
}

resource "aws_cloudwatch_metric_alarm" "db_cpu_alarm" {
  alarm_name                = "db-cpu"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors db cpu utilization"
  insufficient_data_actions = []
  alarm_actions             = [aws_sns_topic.db_alerts.arn]
}
