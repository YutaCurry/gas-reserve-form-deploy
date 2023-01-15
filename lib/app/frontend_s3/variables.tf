variable "distComment" {
  description = "AWSコンソールの表示名"
  type        = string
  nullable    = false
}
variable "s3BucketName" {
  type     = string
  nullable = false
}
variable "distEnable" {
  type    = bool
  default = true
}
variable "distDefault_root_object" {
  type    = string
  default = "index.html"
}
