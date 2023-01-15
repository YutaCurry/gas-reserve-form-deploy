provider "aws" {
  region = "ap-northeast-1"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "state" {
  bucket = "terraform-state-${var.appName}"
}

data "aws_iam_policy_document" "state" {
  statement {
    sid = "1"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.state.arn,
    ]
  }
  statement {
    sid = "2"

    principals {
      type        = "AWS"
      identifiers = [data.aws_caller_identity.current.account_id]
    }

    actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject", ]

    resources = [
      "${aws_s3_bucket.state.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "state" {
  bucket = aws_s3_bucket.state.id
  policy = data.aws_iam_policy_document.state.json
}
