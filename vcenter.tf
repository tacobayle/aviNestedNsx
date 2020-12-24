resource "null_resource" "vcenter" {

  provisioner "local-exec" {
    command = "sudo mkdir -p /mnt/vcsa ; sudo mount -o loop ${var.nestedVcenter.isoPath} /mnt/vcsa ; sudo cp /mnt/vcsa/vcsa/*.ova ~/vsca.ova ; sudo chown ${var.jump.username} ~/vsca.ova ; sudo chgrp ${var.jump.username} ~/vsca.ova ; sudo umount /mnt/vcsa"
  }
}

//guestinfo.cis.appliance.net.dns.servers
//guestinfo.cis.ad.domain.password
//vami.domain.VMware-vCenter-Server-Appliance = nsx.avidemo.fr
//vami.searchpath.VMware-vCenter-Server-Appliance = nsx.avidemo.fr
//guestinfo.cis.deployment.node.type = embedded
//guestinfo.cis.appliance.net.mode = static
//guestinfo.cis.db.password
//guestinfo.cis.appliance.net.gateway = 10.41.132.1
//guestinfo.cis.upgrade.source.guest.password
//guestinfo.cis.appliance.net.prefix = 22
//guestinfo.cis.appliance.net.addr = 10.41.134.134
//guestinfo.cis.upgrade.source.vpxd.password
//guestinfo.cis.upgrade.source.guestops.host.password
//guestinfo.cis.ceip_enabled = False
//guestinfo.cis.vpxd.ha.management.password
//guestinfo.cis.hadcs.enabled = True
//guestinfo.cis.vmdir.password
//guestinfo.cis.vpxd.ha.management.port = 443
//guestinfo.cis.appliance.root.passwd
//guestinfo.cis.appliance.net.addr.family = ipv4