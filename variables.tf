# Sysdig Access key
variable "access_key" {
    type = string
}

# Sysdig Secure API Token
variable "secure_api_token" {
    type = string
}

# AWSリージョン
variable "region" {
    type = string
    default = "ap-northeast-1"
}

# リソース名のプレフィックス
variable "prefix" {
    type = string
    default = "sysdigagt-migration"
}

# 自身のSysdig SaaSリージョンのSecure Endpointの値
variable "sysdig_secure_url" {
  type = string
  default = "https://us2.app.sysdig.com"
}

# 自身のSysdig SaaSリージョンのCollector Endpointの値
variable "collector_url" {
  type = string
  default = "ingest-us2.app.sysdig.com"
}

# Curlコマンドで疑似アタックを実行するターミナル（操作端末）のIPアドレス
variable "source_ip" {
    type = string
}
