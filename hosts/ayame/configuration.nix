{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./desktop.nix
    ../../modules/de/kde.nix
    ./hardware-configuration.nix
    ../../modules/grub.nix
    # ../../modules/ai.nix
    # ../../modules/amdgpu-patch/default.nix
    # ../../modules/amdgpu.nix
    ../../modules/amdgpu-gaming.nix
    ../../modules/cli.nix
    # ../../modules/default.nix
    # ../../modules/desktop.nix
    ../../modules/dev/default.nix
    ../../modules/gaming.nix
    # ../../modules/gui-extras.nix
    ../../modules/gui-plus.nix
    ../../modules/vr.nix
    # ../../modules/gui.nix
    # ../../modules/home.nix
    # ../../modules/led.nix
    # ../../modules/msib450mpro.nix
    # ../../modules/printing.nix
    # ../../modules/prometheus.nix
    # ../../modules/secureboot.nix
    # ../../modules/security.nix
    ../../modules/ssh.nix
    ../../modules/plymouth.nix
    # ../../modules/gnome.nix
    # ../../modules/virt.nix
    # ../../modules/work.nix

    ## konsv
    ../../modules/web.nix
    ../../modules/tui.nix
    ../../modules/media.nix

    # steam boot
    # ../../modules/steam-boot.nix
  ];

  networking.hostName = "ayame"; # Define your hostname.

  # services.xserver.enable = true;
  # services.xserver.videoDrivers = ["amdgpu"];

  # Enable AMD GPU overclocking
  # boot.kernelParams = ["amdgpu.ppfeaturemask=0xfffffff"];
  # boot.kernelPatches = [
  #   {
  #     name = "amdgpu-ignore-ctx-privileges";
  #     patch = pkgs.fetchpatch {
  #       name = "cap_sys_nice_begone.patch";
  #       url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
  #       hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
  #     };
  #   }
  # ];

  # Enable nct6775 module for sensor readings
  # boot.kernelModules = ["nct6775" "amdgpu"];

  # Enable firmware service
  services.fwupd.enable = true;
}
