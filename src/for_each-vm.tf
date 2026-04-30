locals {
  each_vm_map = {
    for vm in var.each_vm :
    vm.vm_name => vm
  }
}

resource "yandex_compute_instance" "db" {
  for_each = local.each_vm_map

  name        = each.value.vm_name
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id          = data.yandex_vpc_subnet.existing.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = <<EOF
${local.ssh_key}
EOF
  }
}
