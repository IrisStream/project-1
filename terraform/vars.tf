variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created"
  default     = "Southeast Asia"
}

variable "username" {
  description = "The admin username of virtual machine"
  default     = "adminuser"
}

variable "password" {
  description = "The admin password of virtual machine"
}
