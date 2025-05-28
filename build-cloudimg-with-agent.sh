#!/bin/bash

set -e

# === Настройки ===
UBUNTU_RELEASE="jammy"
IMAGE_URL="https://cloud-images.ubuntu.com/${UBUNTU_RELEASE}/current/${UBUNTU_RELEASE}-server-cloudimg-amd64.img"
ORIGINAL_IMAGE="ubuntu-${UBUNTU_RELEASE}.qcow2"
FINAL_IMAGE="ubuntu-${UBUNTU_RELEASE}-cloudinit-qemu-agent.qcow2"

echo "[*] Проверка зависимостей..."
REQUIRED_CMDS=(wget qemu-img virt-customize)
for cmd in "${REQUIRED_CMDS[@]}"; do
    if ! command -v $cmd &> /dev/null; then
        echo "Ошибка: Требуется утилита '$cmd'. Установи через 'sudo apt install $cmd'"
        exit 1
    fi
done

echo "[*] Скачиваем образ Ubuntu: $IMAGE_URL"
wget -O "$ORIGINAL_IMAGE" "$IMAGE_URL"

echo "[*] Копируем образ для модификации..."
cp "$ORIGINAL_IMAGE" "$FINAL_IMAGE"

echo "[*] Устанавливаем qemu-guest-agent внутрь образа..."
virt-customize -a "$FINAL_IMAGE" \
    --install qemu-guest-agent \
    --run-command "systemctl enable qemu-guest-agent" \
    --run-command "systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target" \
    --run-command "systemctl disable unattended-upgrades"

echo "[✓] Образ готов: $FINAL_IMAGE"
echo "💡 Теперь можешь загрузить его в Proxmox или использовать в Terraform."
