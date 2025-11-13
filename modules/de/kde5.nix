{remote, ...}: {
  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };

    xrdp =
      if remote
      then {
        enable = true;
        defaultWindowManager = "startplasma-x11";
        openFirewall = true;
      }
      else {};
  };
}
