variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet_ids" {
  type    = list(any)
  default = []
}

variable "user_ip" {
  type    = string
  default = ""
}

variable "db_name" {
  type    = string
  default = "postgres"
}

variable "db_user" {
  type    = string
  default = ""
}

variable "db_pass" {
  type    = string
  default = ""
}

variable "db_storage" {
  type    = number
  default = 10
}

variable "db_type" {
  type    = string
  default = "db.t4g.micro"
}

variable "dns_zone" {
  type    = string
  default = "my.test"
}
