variable "flow" {
  type    = string
  default = "36-10"
}

variable "cloud_id" {
  type    = string
  default = "b1gd2gsrrlqn70h6kj6a"
}

variable "folder_id" {
  type    = string
  default = "b1gklg21hdhribb2tkq1"
}

variable "test" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}