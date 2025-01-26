provider "aws" {
  region = "ap-northeast-1"
}
provider "sysdig" {
  sysdig_secure_api_token = var.secure_api_token
}