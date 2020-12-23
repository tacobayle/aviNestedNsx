resource "null_resource" "vcenter" {

  provisioner "local-exec" {
    command = "sudo mkdir -p /mnt/vcsa ; sudo mount -o loop ${var.nestedVcenter.isoPath} /mnt/vcsa ; sudo cp /mnt/vcsa/vcsa/*.ova ~/vsca.ova ; sudo umount /mnt/vcsa"
  }
}