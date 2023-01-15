resource "aws_s3_bucket" "frontend_bucket" {
  bucket = var.s3BucketName
}

resource "aws_cloudfront_origin_access_control" "frontend_bucket" {
  name                              = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
  description                       = ""
}

resource "aws_cloudfront_cache_policy" "frontend_bucket" {
  name    = "Managed-CachingOptimized"
  comment = "Default policy when CF compression is enabled"
  min_ttl = 1
  parameters_in_cache_key_and_forwarded_to_origin {
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "s3_front_distribution" {
  enabled             = var.distEnable
  comment             = var.distComment
  default_root_object = var.distDefault_root_object
  is_ipv6_enabled     = true
  price_class         = "PriceClass_200"
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
    viewer_protocol_policy = "allow-all"
    compress               = true
    cache_policy_id        = aws_cloudfront_cache_policy.frontend_bucket.id
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  origin {
    origin_id                = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
    domain_name              = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend_bucket.id
  }
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
