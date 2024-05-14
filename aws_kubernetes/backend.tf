terraform {
  backend "s3" {
    bucket = "tfstate-sl-aws"
    key    = "training/terraform_state.tfstate"
    region = "eu-north-1"
  }
}
