terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
  }
}

provider "aws" {
  region = var.aws_configs.region
  default_tags {
    tags = var.aws_configs.tags
  }
}