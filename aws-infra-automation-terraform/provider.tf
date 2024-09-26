terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Specify the version you want to use
    }
  }
}

provider "aws" {
  region = var.region
}