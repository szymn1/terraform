# data "aws_vpc" "selected" {
#   id = var.vpc_id
# }

# data "aws_subnets" "example" {
#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.selected.id]
#   }
# }

# data "aws_subnet" "example" {
#   for_each = toset(data.aws_subnets.example.ids)
#   id       = each.value
# }
