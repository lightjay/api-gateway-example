terraform {
  backend "s3" {
    region = "us-west-2"
    bucket = "config-bucket-100648102620-us-west-2"
    key = "tf/api-gateway-example.tfstate"
  }
}

provider "aws" {
  region = local.region
}