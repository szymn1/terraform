variable "cluster_name" {
  type    = string
  default = ""
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
