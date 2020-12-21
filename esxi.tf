resource "vsphere_virtual_machine" "esxi" {
  count            = length(var.esxi.addresses)
  name             = "${var.esxi.name}-${count.index}"
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
  wait_for_guest_net_timeout = var.esxi.wait_for_guest_net_timeout
  nested_hv_enabled = var.esxi.nested_hv_enabled

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
      "guestinfo.ipaddress" = element(var.esxi.addresses, count.index)
      "guestinfo.netmask"   = var.esxi.netmask
      "guestinfo.gateway"   = var.esxi.gateway
      "guestinfo.dns"       = var.esxi.dns
      "guestinfo.password"  = var.esxi_password
      "guestinfo.hostname"  = "esxi-${count.index}"
    }
  }
}
