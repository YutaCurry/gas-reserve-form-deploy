provider "aws" {
  region = "ap-northeast-1"
}

module "app" {
  source       = "../../lib/app/frontend_s3"
  s3BucketName = "${var.appName}-${var.env}"
  distComment  = var.comment
}
