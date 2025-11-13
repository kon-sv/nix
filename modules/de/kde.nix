{pkgs, ...}: {
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma"; # plasma/plasmax11

  security.pam.services.kwallet = {
    name = "kdewallet";
    enableKwallet = true;
  };

  users.users.konsv = {
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kwallet-pam
    ];
  };
}
