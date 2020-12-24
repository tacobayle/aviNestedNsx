resource "dns_a_record_set" "esxi" {
  depends_on = [vsphere_virtual_machine.jump]
  count = length(var.esxi.addresses)
  zone  = "${var.bind.domain}."
  name  = "${var.esxi.name}-${count.index}"
  addresses = [element(var.esxi.addresses, count.index)]
  ttl = 60
}

resource "dns_ptr_record" "esxi" {
  depends_on = [vsphere_virtual_machine.jump]
  count = length(var.esxi.addresses)
  zone = "${var.bind.reverse}.in-addr.arpa."
  name = split(".", element(var.esxi.addresses, count.index))[3]
  ptr  = "${var.esxi.name}-${count.index}."
  ttl  = 60
}

resource "dns_a_record_set" "vcenter" {
  depends_on = [vsphere_virtual_machine.jump]
  zone  = "${var.bind.domain}."
  name  = var.nestedVcenter.name
  addresses = [split("/", var.nestedVcenter.ipCidr)[0]]
  ttl = 60
}

resource "dns_ptr_record" "vcenter" {
  depends_on = [vsphere_virtual_machine.jump]
  zone = "${var.bind.reverse}.in-addr.arpa."
  name = "${split(".", split("/", var.nestedVcenter.ipCidr)[0])[3]}."
  ptr  = var.nestedVcenter.name
  ttl  = 60
}