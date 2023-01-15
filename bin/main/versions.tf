
# data "terraform_remote_state" "frontend" {
#   backend = var.env == "local" ? "local" : "s3"

#   config = var.env == "local" ? {
#     path = "..."
#     } : {
#     bucket = "terraform-state-${var.appName}"
#     key    = "${var.env}/frontend/terraform.tfstate"
#     region = "ap-northeast-1"
#   }
# }

terraform {
  backend "s3" {
    region = "ap-northeast-1"
  }
}
