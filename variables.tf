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
    files = ["/home/ubuntu/Nested_ESXi7.0u1_Appliance_Template_v1.ova"]
  }
}

variable "esxi" {
  default = {
    name = "esxi"
    cpu = 8
    memory = 65536
    disk = 512
    addresses = ["10.41.134.131", "10.41.134.132", "10.41.134.133"]
    networkData = "vxw-dvs-34-virtualwire-119-sid-1080118-sof2-01-vc08-avi-dev115"
    dns = "10.23.108.1"
    vmfs = "true"
    netmask = "255.255.252.0"
    gateway = "10.41.132.1"
  }
}

variable "backendIps" {
  type = list
  default = ["10.7.6.10", "10.7.6.11"]
}