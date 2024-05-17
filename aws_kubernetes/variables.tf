variable "vpc_cidr" {
  type = map(string)
  default = {
    p0 : "172.16.0.0/16"
  }
}

variable "public_key" {
  type    = string
  default = ""
}