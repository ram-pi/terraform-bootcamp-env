output "net" {
  value = module.net-vpc.net
}

output "subnet" {
  value = module.net-vpc.subnet
}

output "cidr" {
  value = module.net-vpc.cidr
}

output "jumphost_external_ip" {
  value = module.jumphost.external_ip
}

output "ssh_key_filename" {
  value = module.jumphost.ssh_key_filename
}

output "personal_ip" {
  value = data.http.ip.response_body
}

output "samba_internal_ip" {
  value = module.samba.internal_ip
}

output "gcp_user" {
  value = split("@", data.google_client_openid_userinfo.userinfo.email)[0]
}
