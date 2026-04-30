resource "yandex_compute_instance" "web" {
  count = 2

  depends_on = [
    yandex_compute_instance.db
  ]

  name        = "web-${count.index + 1}"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
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
