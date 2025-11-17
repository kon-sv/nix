# Ayame apart from NixOS has also Arch Linux and Windows installed.
# OS Prober was able to find Windows but I am not sure why it can't for Arch
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = false;
    };
    grub = {
      enable = true;
      default = "saved";
      useOSProber = true;
      #copyKernels = true;
      #efiInstallAsRemovable = false;
      efiSupport = true;
      #fsIdentifier          = "label";
      # devices               = [ "nodev" ];
      devices = [
        # "/dev/disk/by-uuid/62E2-26FA"
        "nodev"
      ];
      # device = "/dev/nvme1n1";
      extraEntries = ''
        menuentry 'Arch Linux' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'gnulinux-simple-31e93385-bf16-41c6-b965-13d8688fbe99' {
        	savedefault
        	set gfxpayload=keep
        	insmod gzio
        	insmod part_gpt
        	insmod fat
        	search --no-floppy --fs-uuid --set=root 62E2-26FA
        	echo	'Loading Linux linux-zen ...'
        	linux	/vmlinuz-linux-zen root=UUID=31e93385-bf16-41c6-b965-13d8688fbe99 rw  loglevel=3 quiet acpi_osi=Linux
        	echo	'Loading initial ramdisk ...'
        	initrd	/amd-ucode.img /initramfs-linux-zen.img
        }

               menuentry "Reboot" {
                   reboot
               }
               menuentry "Poweroff" {
                   halt
               }

      '';
    };
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelParams = [
    "quiet"

    # amd and mem sleep stuff were add because the system was sometimes stuttering.
    # read this: https://discourse.nixos.org/t/lockups-with-kernel-6-14-7-and-amd-gpus/64585/2
    # Problem with those is once the pc sleeps it crashes
    # "amdgpu.dcdebugmask=0x10"
    # "mem_sleep_default=s2idle"
    # "amdgpu.noretry=0"
    # "amdgpu.vm_update_mode=3"
    # "amdgpu.sg_display=0"
    # "amdgpu.preempt_mm=0" # the supposed, magic fix
  ];
}
