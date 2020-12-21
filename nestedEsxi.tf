resource "vsphere_virtual_machine" "esxi" {
  count            = length(var.esxi.addresses)
  name             = "esxi-${count.index}"
  datastore_id     = data.vsphere_datastore.datastore.id
  resource_pool_id = data.vsphere_resource_pool.pool.id
  folder           = vsphere_folder.folder.path
  network_interface {
    network_id = data.vsphere_network.networkMgt.id
  }

//  network_interface {
//    network_id = data.vsphere_network.networkData.id
//  }

  num_cpus = var.esxi.cpu
  memory = var.esxi.memory
  guest_id = "esxi-${count.index}"

  disk {
    size             = var.esxi.disk
    label            = "esxi-${count.index}.lab_vmdk"
    thin_provisioned = true
  }

  clone {
    template_uuid = vsphere_content_library_item.files[0].id
  }

  vapp {
    properties = {
      "ipaddress"     = element(var.esxi.addresses, count.index)
      "netmask"   = var.esxi.netmask
      "gateway"  = var.esxi.gateway
      "dns" = var.esxi.dns
      "password" = var.esxi_password
      "hostname" = "esxi-${count.index}"
    }
  }
}
