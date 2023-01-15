
output "aws_s3_bucket" {
  description = "S3"
  value       = aws_s3_bucket.frontend_bucket
}
output "aws_cloudfront_cache_policy" {
  description = "cachePolicy"
  value       = aws_cloudfront_cache_policy.frontend_bucket
}
output "aws_cloudfront_distribution" {
  description = "distribution"
  value       = aws_cloudfront_distribution.s3_front_distribution
}
