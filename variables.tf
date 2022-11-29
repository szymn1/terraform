variable "vpc_id" {
  type    = string
  default = ""
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
