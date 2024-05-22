variable "cluster_name" {
  type    = string
  default = ""
}

variable "role" {
  type = any
}

variable "subnet_ids" {
  type    = set(string)
  default = []
}

variable "instance_types" {
  type    = list(any)
  default = ["t3.micro"]
}

variable "ec2_ssh_key" {
  type    = string
  default = ""
}

variable "source_security_group_id" {
  type    = string
  default = ""
}

variable "node_group_scaling" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  default = {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

variable "max_unavailable" {
  type    = number
  default = 1
}
