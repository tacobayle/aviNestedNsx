resource "null_resource" "vcenter" {

  provisioner "local-exec" {
    command = "sudo mkdir -p /mnt/vcsa ; sudo mount -o loop ${var.nestedVcenter.isoPath} /mnt/vcsa ; cp /mnt/vcsa/vcsa/VMware-vCenter-Server-Appliance-7.0.1.00200-17327517_OVF10.ova ~/ ; sudo umount /mnt/vcsa"
  }
}