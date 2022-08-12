provider "google" {
  project = var.project
  region  = var.region
}

provider "tls" {}

// our public ip
data "http" "ip" {
  url = "https://ifconfig.me"
}

// gcp user account
data "google_client_openid_userinfo" "userinfo" {}

module "net-vpc" {
  source = "../../modules/net-vpc"

  region = var.region
  cidr   = var.cidr
  net    = var.net
  subnet = var.subnet
}

module "jumphost" {
  source = "../../modules/host"
  depends_on = [
    module.net-vpc
  ]

  name         = var.jumphost_name
  zone         = var.zone
  machine_type = var.jumphost_machine_type
  net          = var.net
  subnet       = var.subnet
  #metadata_startup_script = var.jumphost_metadata_startup_script
  metadata_startup_script = var.jumphost_script_filepath
  image_project           = var.jumphost_image_project
  image_family            = var.jumphost_image_family
  instance_tags           = var.jumphost_instance_tags
  is_public               = var.jumphost_is_public
  ssh_from                = data.http.ip.response_body
}

module "samba" {
  source = "../../modules/host"
  depends_on = [
    module.net-vpc
  ]

  name                    = var.samba_name
  zone                    = var.zone
  machine_type            = var.samba_machine_type
  net                     = var.net
  subnet                  = var.subnet
  metadata_startup_script = var.samba_script_filepath
  image_project           = var.samba_image_project
  image_family            = var.samba_image_family
  instance_tags           = var.samba_instance_tags
  is_public               = var.samba_is_public
  ssh_from                = module.jumphost.internal_ip
}

# empty resource for provisioner purposes
resource "null_resource" "jumphost" {
  depends_on = [
    module.samba
  ]

  // ssh to jumphost
  connection {
    host        = module.jumphost.external_ip
    type        = "ssh"
    user        = split("@", data.google_client_openid_userinfo.userinfo.email)[0]
    private_key = file("${var.jumphost_name}.pem")
  }

  // upload samba pem on jumphost
  provisioner "file" {
    source      = "./${var.samba_name}.pem"
    destination = "~/${var.samba_name}.pem"
  }
}
