terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    http = {

    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}
