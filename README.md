

# Cross-Platform Chroot Manager

Cross-Platform Chroot Manager is a tool for managing different operating systems in chroot environments. This tool provides options to list, add (including installation), remove, and clean up operating systems.

## Features

- List available operating systems.
- Add or install an operating system.
- Remove an operating system.
- Clean up existing operating systems not in the list.

## Supported Architectures

The following architectures are supported:

- `qemu-aarch64-static`
- `qemu-hexagon-static`
- `qemu-mips-static`
- `qemu-nios2-static`
- `qemu-riscv64-static`
- `qemu-sparc64-static`
- `qemu-aarch64_be-static`
- `qemu-hppa-static`
- `qemu-mips64-static`
- `qemu-or1k-static`
- `qemu-s390x-static`
- `qemu-x86_64-static`
- `qemu-alpha-static`
- `qemu-i386-static`
- `qemu-mips64el-static`
- `qemu-ppc-static`
- `qemu-sh4-static`
- `qemu-xtensa-static`
- `qemu-arm-static`
- `qemu-m68k-static`
- `qemu-mipsel-static`
- `qemu-ppc64-static`
- `qemu-sh4eb-static`
- `qemu-xtensaeb-static`
- `qemu-armeb-static`
- `qemu-microblaze-static`
- `qemu-mipsn32-static`
- `qemu-ppc64le-static`
- `qemu-sparc-static`
- `qemu-cris-static`
- `qemu-microblazeel-static`
- `qemu-mipsn32el-static`
- `qemu-riscv32-static`
- `qemu-sparc32plus-static`

## Usage

1. Clone this repository:

   ```shell
   git clone https://github.com/dikeckaan/Chroot-Manager.git
   cd Chroot-Manager
   ```

2. Run the script:

   ```shell
   ./chroot-manager.sh
   ```

3. Follow the on-screen instructions to perform various operations:

   - **List available operating systems**: Displays the list of operating systems available in the chroot environments.
   - **Add or install an operating system**: Adds a new operating system to the list and installs it in a chroot environment.
   - **Remove an operating system**: Removes an operating system from the list and cleans up its associated chroot environment.
   - **Clean up existing operating systems**: Removes existing operating systems that are not present in the list and cleans up their chroot environments.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).
