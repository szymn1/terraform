data "aws_key_pair" "deployer" {
  key_name           = "deployer"
  include_public_key = true
}

data "aws_availability_zones" "available" {
  state = "available"
}
