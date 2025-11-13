{
  pkgs,
  vars,
  ...
}: {
  ## Most of the configurations here are aimed for AI

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    amdvlk
  ];

  # For 32 bit applications
  hardware.graphics.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true; # For 32 bit applications

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  users.users.${vars.user} = {
    packages = with pkgs; [
      amdgpu_top
      blender-hip
    ];
  };

  environment.systemPackages = with pkgs; [
    corectrl
    vulkan-tools
  ];

  # Corectrl without password
  security.polkit = {
    extraConfig = ''
      polkit.addRule(function(action, subject) {
          if ((action.id == "org.corectrl.helper.init" ||
               action.id == "org.corectrl.helperkiller.init") &&
              subject.local == true &&
              subject.active == true &&
              subject.isInGroup("wheel")) {
                  return polkit.Result.YES;
          }
      });
    '';
  };
}
