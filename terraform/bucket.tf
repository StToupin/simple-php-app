terraform {
  backend "s3" {
    bucket = "stoupin"
    key    = "tfstate"
    region = "us-east-2"
  }
}
