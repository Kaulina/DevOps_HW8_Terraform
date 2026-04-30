data "yandex_vpc_network" "existing" {
  network_id = "enp01orc09siakgd0puj"
}

data "yandex_vpc_subnet" "existing" {
  subnet_id = "e9b9ebgfeap0lqi3ab35"
}
