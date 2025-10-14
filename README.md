Создать сервисный аккаунт в облаке. Выдать права editor
Выпустить авторизованный ключ для этого аккаунта и скачать его по пути ~/.authorized_key.json .
Вписать в переменные cloud_id и folder_id в variables.tf
Изменить ssh-ключ в файле cloud-init.yml (ssh-keygen -t ed25519). cp terraformrc ~/.terraformrc
terraform init && terraform apply
rm ~/.ssh/known_hosts. Выполнить playbook ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./hosts.ini test.yml
По окончании выполнить terraform destroy
https://www.jeffgeerling.com/blog/2022/using-ansible-playbook-ssh-bastion-jump-host

Настройка доступа по ssh через ssh config: ~/.ssh/config

Host 89.169.142.236  #адрес вашего бастиона
   User user

Host 10.0.*
        ProxyJump 89.169.142.236
        User user

Host *.ru-central1.internal
        ProxyJump 89.169.142.236
        User user

Или более простой для понимания, но менее удобный для частого применения: ssh -J





ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ./hosts.ini nginx_install.yml
ANSIBLE_HOST_KEY_CHECKING=False ansible -i hosts.ini all -m ping -vvv