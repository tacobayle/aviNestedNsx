#
# Environment Variables
#
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "avi_password" {}
variable "avi_user" {}
variable "esxi_password" {}
#
# Other Variables
#
variable "vcenter" {
  type = map
  default = {
    dc = "sof2-01-vc08"
    cluster = "sof2-01-vc08c01"
    datastore = "sof2-01-vc08c01-vsan"
    resource_pool = "sof2-01-vc08c01/Resources"
    folder = "NicNestedNsx"
    networkMgmt = "vxw-dvs-34-virtualwire-3-sid-1080002-sof2-01-vc08-avi-mgmt"
  }
}

variable "contentLibrary" {
  default = {
    name = "Nested NSX build"
    description = "Nested NSX build"
    files = ["/home/ubuntu/Nested_ESXi7.0u1_Appliance_Template_v1.ova", "/home/ubuntu/bionic-server-cloudimg-amd64.ova", "/home/ubuntu/vsca.ova"]
  }
}

variable "esxi" {
  default = {
    name = "esxi"
    cpu = 8
    memory = 65536
    disk = 512
    wait_for_guest_net_timeout = 0
    nested_hv_enabled = "true"
    addresses = ["10.41.134.131", "10.41.134.132", "10.41.134.133"]
    networkData = "vxw-dvs-34-virtualwire-119-sid-1080118-sof2-01-vc08-avi-dev115"
    dns = "10.23.108.1"
    vmfs = "true"
    netmask = "255.255.252.0"
    gateway = "10.41.132.1"
  }
}

variable "nestedVcenter" {
  default = {
    isoPath = "/home/ubuntu/VMware-VCSA-all-7.0.1-17327517.iso"
    ipCidr = "10.41.134.134/22"
  }
}

variable "jump" {
  type = map
  default = {
    name = "jump"
    cpu = 2
    memory = 4096
    disk = 20
    public_key_path = "~/.ssh/cloudKey.pub"
    private_key_path = "~/.ssh/cloudKey"
    wait_for_guest_net_timeout = 2
    username = "ubuntu"
    ipCidr = "10.41.134.135/22"
    dns = "10.23.108.1, 10.16.142.111"
    defaultGw = "10.0.0.1"
    netplanFile = "/etc/netplan/50-cloud-init.yaml"
  }
}

variable "bind" {
  default = {
    forwarder = "10.23.108.1"
    domain = "nsx.avidemo.fr"
    reverse = "10.41.134"
  }
}