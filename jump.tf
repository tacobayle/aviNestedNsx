data "template_file" "jumpbox_userdata" {
  template = file("${path.module}/userdata/jump.userdata")
  vars = {
    pubkey        = file(var.jump.public_key_path)
    username = var.jump.username
    ipCidr  = var.jump.ipCidr
    ip = split("/", var.jump.ipCidr)[0]
    lastOctet = split(".", split("/", var.jump.ipCidr)[0])[3]
    defaultGw = var.jump.defaultGw
    dns      = var.jump.dns
    netplanFile = var.jump.netplanFile
    privateKey = var.jump.private_key_path
    forwarders = var.bind.forwarders
    domain = var.bind.domain
    reverse = var.bind.reverse
    keyName = var.bind.keyName
    secret = base64encode(var.bind_password)
  }
}

resource "vsphere_virtual_machine" "jump" {
  name             = var.jump.name
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = vsphere_folder.folder.path
  network_interface {
    network_id = data.vsphere_network.networkMgt.id
  }

  num_cpus = var.jump.cpu
  memory = var.jump.memory
  wait_for_guest_net_timeout = var.jump.wait_for_guest_net_timeout
  guest_id = "jump-${var.jump.name}"

  disk {
    size             = var.jump.disk
    label            = "jump.lab_vmdk"
    thin_provisioned = true
  }

  cdrom {
    client_device = true
  }

  clone {
    template_uuid = vsphere_content_library_item.files[1].id
  }

  vapp {
    properties = {
      hostname    = var.jump.name
      public-keys = file(var.jump.public_key_path)
      user-data   = base64encode(data.template_file.jumpbox_userdata.rendered)
    }
  }

  connection {
    host        = split("/", var.jump.ipCidr)[0]
    type        = "ssh"
    agent       = false
    user        = var.jump.username
    private_key = file(var.jump.private_key_path)
  }

  provisioner "remote-exec" {
    inline      = [
      "while [ ! -f /tmp/cloudInitDone.log ]; do sleep 1; done"
    ]
  }
}