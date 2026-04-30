# Домашнее задание к занятию «Управляющие конструкции в коде Terraform»

## Задание 1

инициировала terraform через команду terraform init, выполнила terraform plan и применила - terraform apply

![1](screenshots/1.2.png)

из-за ограничения квоты на количество сетей в YC, я использовала существующую сеть и подсеть через data.tf.

и создала группу безопасности с динамическими правилами.

![1](screenshots/1.1.png)

## Задание 2

### Задание 2.1

для создания 2х ВМ в YC, я использовала параметр count

создала файл count-vm.tf

![2.1](screenshots/2.3.png)

использовала уже существующую сеть через data.tf.

выполнила команды:
```docker
terraform init
terraform plan
terraform apply
```
![2.2](screenshots/2.2.png)

в результате было создано 2 ВМ: web-1 и web-2

![2.3](screenshots/2.1.png)

обе машины в зоне ru-central1-a, имеют публичный ip, и в статусе running. 

### Задание 2.2

создала переменные vm_list типа map(object) в новом файле for_each-vm.tf

![3.1](screenshots/3.2.png)

rоманда terraform apply создала две ВМ: web-1 и web-2

![3.1](screenshots/3.1.png)

обе машины развернуты в зоне ru-central1-a и в статусе running

![3.1](screenshots/3.3.png)

### Задание 2.4

ВМ main и replica (for_each)

![2.4](screenshots/2.4.for.png)

ВМ web-1 и web-2 (count)

![2.5](screenshots/2.5.count.png)

добавила запись зависимости:
```docker
depends_on = [
  yandex_compute_instance.db
]
```

в итоге выполняется последовательное создание db → web.

### Задание 2.5

добавила переменную в файл variables.tf
```docker
locals {
  ssh_key = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
}
```

в metadata:
```docker
metadata = {
  ssh-keys = <<EOF
${local.ssh_key}
EOF
}
```

проинициализировала проект 
```docker
terraform init
terraform plan
terraform apply
```

## Задание 3

создала 3 одинаковых диска через count в файле disk_vm.tf
```docker
resource "yandex_compute_disk" "storage" {
  count = 3
  name  = "storage-disk-${count.index + 1}"
  size  = 1
  type  = "network-hdd"
  zone  = var.default_zone
}
```

![3](screenshots/3.4.png)

![3](screenshots/3.5.png)

## Задание 4

создала ansible.tf и hosts.tftpl
провела форматирование и проверку, выполнила terraform apply. После того, как отработал запрос, сформировался файл hosts.ini 

![4.1](screenshots/4.1.png)


