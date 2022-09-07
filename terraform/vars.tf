variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
}

variable "application_port" {
  description = "The application port"
  default     = 80
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

variable "minimum_instance" {
  description = "The minimun instance of virtual machine scale set"
  default     = 1
}

variable "maximum_instance" {
  description = "The maximum instance of virtual machine scale set"
  default     = 4
}

variable "image_name" {
  description = "The custom image for creating instance in scale set"
  default     = "project-1-image"
}

locals {
  tags = {
    project = "udacity"
  }
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDWPAUBOHhg74I4wAW6TefgXJ3LMXApWN+N2dm6NJiwiKZh6OC2qvxnc5bkFNInCK0ZtmsNVzNoK6agteBb8/VyXQpags7fOBDh2CUtXXxq/oPxy+nkTcxqzslsvgfWiDq+ie9J1WFAoSxb7ERtv7/mcQUYE1QvsyzK2MS+iineZhnIyyuyZvtfmLDr7SqGz3weJqRHRKO2w8dB1HBz8r+0QaEr53bEy19i1CWwEqqwTblc+R5cTCEjhZBz4NRqFovIZ60RdzkhTPzSxauXgmPTi7akAyJca1XTO9kB7Bu/fJFB9ptJpoxFYWmnJixb5MeX3hxQjzEJUNhyv6P9/Ix4qhUeJO9ELGPAVeJ51QJ87RczxGtGUt8SAzKx7Gi64vDrop94EEp6ieddrEjxGgJIokp8rR1jJJacdcKoZH2vrIaz/HEqpeftnC5vyMGmSP1LwFbcUg4KfuMN4RQA9JD3jh5oyhhVPiN+GLPY+Re5uoevlST2Qhr5b+ePVoYs63E= udacity_azure"
}