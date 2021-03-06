provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

provider "dns" {
  update {
    server        = split("/", var.jump.ipCidr)[0]
    key_name      = "${var.bind.keyName}."
    key_algorithm = "hmac-md5"
    key_secret    = base64encode(var.bind_password)
  }
}