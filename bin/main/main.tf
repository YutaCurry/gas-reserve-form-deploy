provider "aws" {
  region = "ap-northeast-1"
}

locals {
  s3BucketName = var.env == "prod" ? var.appName: "${var.appName}-${var.env}"
}
module "app" {
  source       = "../../lib/app/frontend_s3"
  s3BucketName = local.s3BucketName
  distComment  = var.comment
}
