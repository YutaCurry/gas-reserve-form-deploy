
output "aws_s3_bucket" {
  description = "S3"
  value       = module.app.aws_s3_bucket
}
output "aws_cloudfront_cache_policy" {
  description = "cachePolicy"
  value       = module.app.aws_cloudfront_cache_policy
}
output "aws_cloudfront_distribution" {
  description = "distribution"
  value       = module.app.aws_cloudfront_distribution
}
