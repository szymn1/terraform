# output "subnet_cidr_blocks" {
#   value = [for s in data.aws_subnet.example : s.cidr_block]
# }

output "domain_name" {
  value = aws_lb.test.dns_name
}
