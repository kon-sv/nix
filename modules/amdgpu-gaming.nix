{
  pkgs,
  vars,
  ...
}: {
  # For 32 bit applications
  # hardware.graphics.extraPackages32 = with pkgs; [
  #   driversi686Linux.amdvlk
  # ];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # For 32 bit applications

  users.users.${vars.user} = {
    packages = with pkgs; [
      blender-hip
    ];
  };

  hardware.amdgpu.initrd.enable = true;

  environment.systemPackages = with pkgs; [
    corectrl
    vulkan-tools
    lact
  ];

  # nixos-unstable only
  # services.lact.enable = true;

  systemd.packages = with pkgs; [lact];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  # Corectrl without password
  #   security.polkit = {
  #     extraConfig = ''
  #       polkit.addRule(function(action, subject) {
  #           if ((action.id == "org.corectrl.helper.init" ||
  #                action.id == "org.corectrl.helperkiller.init") &&
  #               subject.local == true &&
  #               subject.active == true &&
  #               subject.isInGroup("wheel")) {
  #                   return polkit.Result.YES;
  #           }
  #       });
  #     '';
  #   };
}
