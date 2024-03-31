terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  access_key = "$ACCES_KEY"
  secret_key = "$SECRET_KEY"
  region     = "sa-east-1"
  profile    = "default"
  token = "$TOKEN"
}