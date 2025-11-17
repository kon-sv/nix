{
  pkgs,
  vars,
  ...
}: {
  # boot.kernelPackages = pkgs.linuxPackages; # (this is the default) some amdgpu issues on 6.10  # set in grub.nix
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
  hardware.xone.enable = true; # support for the xbox controller USB dongle
  services.getty.autologinUser = "your_user";
  environment = {
    systemPackages = with pkgs; [
      mangohud
    ];
    loginShellInit = ''
      [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
    '';
  };
}
