image_id     = "fd84d8ve4g091jun43if"
default_zone = "ru-central1-a"

each_vm = [
  {
    vm_name     = "main"
    cpu         = 2
    ram         = 4
    disk_volume = 20
  },
  {
    vm_name     = "replica"
    cpu         = 2
    ram         = 2
    disk_volume = 10
  }
]

vm_list = {}