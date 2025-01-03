#!/bin/bash

# Update the system
sudo apt update && sudo apt upgrade -y

# Install QEMU, KVM, libvirt, and virt-manager
sudo apt install -y qemu qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager

# Verify that KVM can be used
if grep -E "(vmx|svm)" /proc/cpuinfo > /dev/null; then
    echo "KVM hardware virtualization support is available."
else
    echo "KVM hardware virtualization support is not available. Exiting."
    exit 1
fi

# Add the current user to the libvirt and kvm groups
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG kvm $(whoami)

# Restart libvirtd service
sudo systemctl restart libvirtd

# Enable libvirtd service to start on boot
sudo systemctl enable libvirtd

# Display the status of libvirtd
sudo systemctl status libvirtd

# Create directories for VM images
mkdir -p ~/VMs/Kali ~/VMs/Windows

# Output instructions for downloading ISO files
echo "\nSetup complete! To proceed:"
echo "1. Download the Kali Linux ISO from: https://www.kali.org/get-kali/"
echo "2. Download the Windows ISO from the official Microsoft website or another trusted source."
echo "3. Open virt-manager (type 'virt-manager' in your terminal or app launcher)."
echo "4. Create a new VM and select the downloaded ISO file."
echo "5. Customize VM settings as needed and start the VM."

echo "Reboot your system to apply group membership changes."
