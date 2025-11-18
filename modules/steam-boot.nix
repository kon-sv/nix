{
  pkgs,
  vars,
  ...
}: {
  # boot.kernelPackages = pkgs.linuxPackages; # (this is the default) some amdgpu issues on 6.10  # set in grub.nix
  #

  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma"; # plasma/plasmax11
  services.displayManager.sddm.enable = true;

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

  services.getty.autologinUser = "${vars.user}";

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${vars.user}";

  environment = {
    systemPackages = with pkgs; [
      mangohud
      kdePackages.kwallet-pam
    ];
    loginShellInit = ''
      [[ "$(tty)" = "/dev/tty1" ]] && /home/konsv/nix/gs.sh
    '';
  };
}
