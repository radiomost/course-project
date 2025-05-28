#!/bin/bash

# Настройки
VMID=9000
VM_NAME="ubuntu-jammy-cloudinit-template"
STORAGE="RAID"  # Замените на имя хранилища, например: local-lvm, local-btrfs и т.п.
ISO_IMAGE="ubuntu-jammy-cloudinit-qemu-agent.img"
DISK_SIZE="10G"

echo "=== Импорт образа ==="
# Убедитесь, что ISO_IMAGE уже загружен в каталог Proxmox, например: /var/lib/vz/template/iso/
qm create $VMID --name $VM_NAME --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0

# Импортируем диск
qm importdisk $VMID /var/lib/pve/local-btrfs/template/iso/$ISO_IMAGE $STORAGE

# Подключаем импортированный диск как scsi0
qm set $VMID --scsihw virtio-scsi-pci --scsi0 ${STORAGE}:${VMID}/vm-${VMID}-disk-0.raw

# Настраиваем CloudInit CD-ROM
qm set $VMID --ide2 ${STORAGE}:cloudinit

# Устанавливаем порядок загрузки
qm set $VMID --boot c --bootdisk scsi0

# Включаем консоль и агент
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --agent enabled=1

# Настраиваем размер диска (можно позже увеличить в terraform)
#qm resize $VMID scsi0 $DISK_SIZE

# Делаем шаблоном
qm template $VMID

echo "=== Готово! Шаблон $VM_NAME с VMID=$VMID создан и готов к использованию в Terraform ==="
