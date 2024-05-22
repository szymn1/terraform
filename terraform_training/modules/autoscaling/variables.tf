variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "pub_subnet_id" {
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

variable "ebs_vol_size" {
  type    = number
  default = 8
}

variable "ebs_vol_type" {
  type    = string
  default = "gp3"
}

variable "autoscaling_azs" {
  type    = list(any)
  default = []
}

variable "autoscaling_params" {
  type = object({
    desired_capacity = number
    max_size         = number
    min_size         = number
  })
  default = {
    desired_capacity = 1
    max_size         = 3
    min_size         = 2
  }
}

variable "user_ip" {
  type    = string
  default = ""
}

variable "public_key" {
  type = object({
    name    = string
    content = string
  })
  default = {
    name    = "AWS labs TEST key"
    content = ""
  }
}
