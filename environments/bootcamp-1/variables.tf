variable "project" {}
variable "region" {}
variable "zone" {}
variable "cidr" {}
variable "subnet" {}
variable "net" {}
# jumphost instance
variable "jumphost_name" {}
variable "jumphost_machine_type" {}
#variable "jumphost_metadata_startup_script" {}
variable "jumphost_script_filepath" {}
variable "jumphost_image_family" {}
variable "jumphost_image_project" {}
variable "jumphost_instance_tags" {
  type = list(string)
}
variable "jumphost_is_public" {
  type    = bool
  default = true
}
# samba
variable "samba_name" {}
variable "samba_machine_type" {}
variable "samba_script_filepath" {
  type    = string
  default = null
}
variable "samba_image_family" {}
variable "samba_image_project" {}
variable "samba_instance_tags" {
  type = list(string)
}
variable "samba_is_public" {
  type    = bool
  default = false
}
