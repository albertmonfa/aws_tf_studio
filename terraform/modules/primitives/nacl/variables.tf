variable "vpc_id" {}

variable "name" {
  type = "string"
}

variable "subnet_ids" {
  type = "list"
}

variable "inbound_rules" {
  type = "map"
}

variable "outbound_rules" {
  type = "map"
}

variable "tags" {
  type = "map"
}
