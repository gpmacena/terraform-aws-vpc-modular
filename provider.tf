provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      owner      = "gabrielmacena"
      managed-by = "terraform"
    }
  }
}
