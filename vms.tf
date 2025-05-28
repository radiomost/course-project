resource "proxmox_vm_qemu" "cloudinit-k3s-master" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve1"
    desc = "Cloudinit Ubuntu"
    count = 1
    onboot = true

    # The template name to clone this vm from
    clone = "ubuntu-22.04-template"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 2
    sockets = 2
    numa = true
    vcpus = 0
    cpu = "host"
    memory = 4096
    name = "k3s-master-0${count.index + 1}"
    vmid = 2004+count.index

    # cloudinit_cdrom_storage = "nvme"
    scsihw   = "virtio-scsi-single"

    cloudinit_cdrom_storage = "RAID"
  
    network {
        model  = "virtio"
        bridge = "vmbr1"
        #tag = 256
    }

    disks {
        scsi {
            scsi0 {
                disk {
                    size            = 12
                    cache           = "writeback"
                    storage         = "RAID"
                    replicate       = true               
                }
            }
        }
    }
    bootdisk = "scsi0"
    boot = "order=scsi0"
    
    ipconfig0 = "ip=dhcp"
    # ipconfig0 = "ip=<IP HOST>.5${count.index + 1}/23,gw=<IP GATEWAY>"
    ciuser = "<USERNAME>"
    cipassword = "<USER PASSWORD>"
    # nameserver = "8.8.8.8"
#     sshkeys = <<EOF
# <SSH KEY>
#     EOF
    serial {
      id   = 0
      type = "socket"
    }
}
