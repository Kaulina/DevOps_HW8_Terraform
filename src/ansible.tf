locals {
  webservers = [
    for w in yandex_compute_instance.web :
    {
      name = w.name
      ip   = w.network_interface[0].ip_address
      fqdn = w.fqdn
    }
  ]

  databases = [
    for d in yandex_compute_instance.db :
    {
      name = d.name
      ip   = d.network_interface[0].ip_address
      fqdn = d.fqdn
    }
  ]

  storage = {
    name = yandex_compute_instance.storage.name
    ip   = yandex_compute_instance.storage.network_interface[0].ip_address
    fqdn = yandex_compute_instance.storage.fqdn
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/hosts.ini"

  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
}

resource "null_resource" "run_ansible" {
  depends_on = [
    local_file.ansible_inventory,
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage
  ]

  provisioner "local-exec" {
    command = "ansible-playbook -i hosts.ini playbook.yml"
  }
}
