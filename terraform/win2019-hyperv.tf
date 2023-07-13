provider "hyperv" {
  servername = "localhost"
}

resource "hyperv_virtual_machine" "<hostname>" {
  name                        = "<HOSTNAME>"
  memory                      = 4096
  processor_count             = 2
 # dynamic_memory_enabled      = true
 # dynamic_memory_maximum_bytes = 10737418240  # 10 GB
 # dynamic_memory_minimum_bytes = 536870912     # 512 MB

  network_interface {
    name = "External Network"
  }

  dvd_drive {
    path = "<PATH TO ISO>"
  }

  os_disk {
    path = "<PATH TO VDISK>disk.vhdx"
    size_bytes = 6442450944  # 60 GB
  }

  user {
    username = "<username>"
    password = "<password>"
  }
}
