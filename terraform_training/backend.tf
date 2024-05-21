terraform {
  backend "s3" {
    bucket = "test-6516541681"
    key    = "training/terraform_state.tfstate"
    region = "us-east-2"
  }
}
