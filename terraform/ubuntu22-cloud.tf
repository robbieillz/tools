# Define provider (replace with your own provider configuration)
provider "<aws/ azure/etc>" {
  # Your provider configuration here
}

# Create a virtual machine
resource "your_provider_virtual_machine" "ubuntu" {
  name                    = "ubuntu-vm"
  image                   = "ubuntu-22.04"
  size                    = "small"  # Replace with your desired VM size

  # Network configuration
  network_interface {
    network               = "your_network"
  }

  # Disk configuration
  disk {
    name                  = "ubuntu-disk"
    size                  = 20  # GB
  }
}
