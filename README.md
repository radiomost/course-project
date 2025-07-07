TEST!!!!!!

✅ Сборка образа CloudInit
🔧 Цель:
Создать новый .qcow2-образ на основе официального Ubuntu Cloud Image, но с уже установленным пакетом qemu-guest-agent.

🧰 Что потребуется:
Linux-система с утилитами:

qemu-utils

libguestfs-tools (guestfish, virt-customize)

wget

Образ Ubuntu:

Например: jammy-server-cloudimg-amd64.img

🪛 Шаги
1. Установи необходимые инструменты:

```bash
sudo apt update
sudo apt install libguestfs-tools qemu-utils wget
```
2. Сделай исполняемым:
```bash
chmod +x build-cloudimg-with-agent.sh
```
3. Запусти:
```bash
./build-cloudimg-with-agent.sh
```
📦 Результат
Готовый .qcow2-файл: ubuntu-jammy-cloudinit-qemu-agent.qcow2
Полностью совместим с Proxmox Cloud-Init
Не требует запуска виртуальной машины для установки агента.

Загрузи его в Proxmox

✅ Создание template CloudInit
Скрипт create-cloudinit-template.sh запускается непосредственно на хосте Proxmox.
Незабудь корректно указать путь до хранилища.

```bash
chmod +x create-cloudinit-template.sh
./create-cloudinit-template.sh
```

✅ Запуск Terraform

Праверка плана
```bash
terraform plan -var-file="variables.tfvars"
```
Создание окружения. Запуск
```bash
terraform apply -var-file="variables.tfvars"
```
Удаление созданного окружения.
```bash
terraform destroy -var-file="variables.tfvars"
```
