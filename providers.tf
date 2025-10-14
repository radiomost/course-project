# cat ~/.aws/config 
# [default]
# region=ru-central1
# cat ~/.aws/credentials 
# [default]
# aws_access_key_id = YCAJEK...
# aws_secret_access_key = YCMBzZ3...


#For terraform >=1.6<=1.8.5
terraform {
  required_version = ">=1.8.4"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.129.0"
    }
  }
}

provider "yandex" {
    cloud_id                = var.cloud_id
    folder_id               = var.folder_id
    service_account_key_file = file ("~/.authorized_key.json")
}