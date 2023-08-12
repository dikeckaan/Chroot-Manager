#!/bin/bash

# Function to list available operating systems
list_os() {
  if [ -f "$HOME/.cross/listofoses.txt" ]; then
    echo "Available operating systems:"
    cat "$HOME/.cross/listofoses.txt"
  else
    echo "No operating systems found."
  fi
}

# Function to add or install an operating system
add_os() {
  echo "Enter the name of the operating system:"
  read os_name

  if [ -z "$os_name" ]; then
    echo "Invalid input. Please provide a valid operating system name."
    return
  fi

  if [ -f "$HOME/.cross/listofoses.txt" ]; then
    if grep -Fxq "$os_name" "$HOME/.cross/listofoses.txt"; then
      echo "Operating system already exists in the list."
    else
      echo "$os_name" >> "$HOME/.cross/listofoses.txt"
      echo "Operating system '$os_name' added to the list."
    fi
  else
    echo "$os_name" > "$HOME/.cross/listofoses.txt"
    echo "Operating system '$os_name' added to the list."
  fi

  # Set the distribution and architecture information
  distribution="$os_name"
  release="22.04"
  arch="amd64"

  # Set the specific URL for the distribution
  case "$distribution" in
      "ubuntu")
          url="http://archive.ubuntu.com/ubuntu"
          ;;
      "debian")
          url="http://deb.debian.org/debian"
          ;;
      # Add necessary URLs for other distributions
      *)
          echo "Unsupported distribution: $distribution"
          exit 1
          ;;
  esac

  # Install necessary packages
  sudo apt-get update
  sudo apt-get install -y qemu-user-static schroot debootstrap

  # Create the chroot environment
  sudo debootstrap --arch "$arch" --foreign "$release" "/srv/chroot/$distribution-$arch" "$url"

  # Copy qemu-user-static (required for supported architectures)
  case "$arch" in
      "i386" | "amd64" | "armhf" | "arm64" | "aarch64" | "x86_64")
          sudo cp "/usr/bin/qemu-$arch-static" "/srv/chroot/$distribution-$arch/usr/bin"
          ;;
      # Add necessary commands for other architectures
  esac

  # Perform the second stage of debootstrap
  sudo chroot "/srv/chroot/$distribution-$arch" /debootstrap/debootstrap --second-stage

  # Create the chroot configuration file
  sudo sh -c "echo '[$distribution-$arch]
description=$distribution $release $arch chroot
aliases=$distribution-$arch
type=directory
directory=/srv/chroot/$distribution-$arch
profile=desktop
personality=linux
preserve-environment=true' > /etc/schroot/chroot.d/$distribution-$arch.conf"

  # Enter the chroot environment
  sudo schroot -c "$distribution-$arch"
}

# Function to clean up existing operating systems not in the list
clean_up_os() {
  echo "Cleaning up existing operating systems not in the list..."
  
  if [ -f "$HOME/.cross/listofoses.txt" ]; then
    while IFS= read -r os; do
      if ! grep -Fxq "$os" "$HOME/.cross/listofoses.txt"; then
        sudo rm -rf "/srv/chroot/$os-amd64"
        sudo rm -f "/etc/schroot/chroot.d/$os-amd64.conf"
        echo "Operating system '$os' removed."
      fi
    done < <(ls -d /srv/chroot/*-amd64 2>/dev/null | grep -oP "(?<=/srv/chroot/).*?(?=-amd64)")
  fi

  echo "Cleanup completed."
}

# Main menu
while true; do
  echo
  echo "Cross-Platform Chroot Manager"
  echo "-----------------------------"
  echo "1. List available operating systems"
  echo "2. Add or install an operating system"
  echo "3. Remove an operating system"
  echo "4. Clean up existing operating systems"
  echo "0. Exit"
  echo
  echo -n "Enter your choice: "
  read choice

  case "$choice" in
    1)
      list_os
      ;;
    2)
      add_os
      ;;
    3)
      remove_os
      ;;
    4)
      clean_up_os
      ;;
    0)
      break
      ;;
    *)
      echo "Invalid choice. Please enter a valid option."
      ;;
  esac

  echo
done
