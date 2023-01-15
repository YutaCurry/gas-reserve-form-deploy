variable "appName" {
  type     = string
  nullable = false
}
variable "comment" {
  type     = string
  nullable = false
}
variable "env" {
  type    = string
  default = "local"
}
