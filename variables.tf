variable "vpc_id" {
  type    = string
  default = ""
}

variable "network-cidr" {
  type = map(string)
  default = {
    p0 : "172.16.0.0/16"
  }
}

variable "image_id" {
  type    = string
  default = ""
}

variable "vm_type" {
  type    = string
  default = ""
}

variable "autoscaling_azs" {
  type    = list(any)
  default = []
}

variable "user_ip" {
  type    = string
  default = ""
}

variable "public_key" {
  type    = string
  default = ""
}

variable "db_user" {
  type    = string
  default = ""
}

variable "db_pass" {
  type    = string
  default = ""
}
