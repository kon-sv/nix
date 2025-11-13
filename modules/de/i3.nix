{
  config,
  pkgs,
  callPackage,
  remote,
  ...
}: {
  environment.pathsToLink = ["/libexec"];

  services.displayManager = {
    defaultSession = "none+i3";
  };

  security.pam.services = {
    # Depending on which screen locker you are using, as per
    # https://github.com/NixOS/nixpkgs/pull/399051/files#diff-aef862f6fd2c25092a3f17f974d8757285bf7baff6b80822cd142b7de1903ccfR444
    i3lock.enable = true;
    i3lock-color.enable = true;
    xlock.enable = true;
    xscreensaver.enable = true;
  };

  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
  };

  # services.xserver = {
  #   enable = true;
  #
  #   desktopManager = {
  #     xterm.enable = false;
  #   };
  #
  #   windowManager.i3 = {
  #     enable = true;
  #     extraPackages = with pkgs; [
  #       dmenu #application launcher most people use
  #       i3status # gives you the default i3 status bar
  #       i3blocks #if you are planning on using i3blocks over i3status
  #     ];
  #   };
  # };
  # programs.i3lock.enable = true; #default i3 screen locker

  services.xrdp =
    if remote
    then {
      enable = true;
      defaultWindowManager = "i3";
      openFirewall = true;
    }
    else {};
}
