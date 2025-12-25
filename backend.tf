terraform {
  backend "s3" {
    bucket = "projeto1-terraform-bucket"
    key    = "projeto-cert-terraform/projeto1"
    region = "sa-east-1"
  }
}
