terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.33.0, <5.35.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }


  }
  required_version = "~>1.7.2"
}

provider "aws" {
  region = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
  default_tags {
    tags = var.tags
  }
}



