# Define provider for Hyper-V
provider "hyperv" {
  servername = "localhost"
}

# Create a virtual machine
resource "hyperv_virtual_machine" "<hostname>" {
  name            = "<hostname>"
  generation      = 2
  memory          = 2048  # Amount of RAM in MB
  processor_count = 2     # Number of virtual processors

  # Network configuration
  network_interface {
    name       = "<switch name>" #change switch name
    switch_type = "External"
  }

  # Disk configuration
  disk {
    name = "ubuntu-disk"
    size = 20  # GB
  }

  # Operating system configuration
  os {
    iso_path       = "<PATH TO ISO>"  
    installation   = "Auto"
   
  }

  # Provisioning script
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y zabbix-proxy-mysql",
      # Additional configuration steps for Zabbix Proxy, if needed
    ]
  }
}
