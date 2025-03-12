variable "iname" {
type = string
default = "Terraform_Instance"
}

variable "ami_id" {
type = string
default = "ami-04aa00acb1165b32a"
}

variable "itype" {
type = string
default = "t2.micro"
}

variable "icount" {
type = number
default = 2
}
