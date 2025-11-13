{
  lib,
  pkgs,
  username,
  ...
}: {
  ## Note about vr.nix and amdgpu.nix: I had a few problems with the drivers used from amdgpu. Avoid them when using vr.nix

  environment.systemPackages = [
    pkgs.alvr
    pkgs.opencomposite
    pkgs.xrizer
    pkgs.slimevr
    pkgs.slimevr-server
    pkgs.wlx-overlay-s

    pkgs.bs-manager
  ];

  # Actually enable the program
  programs.alvr = {
    enable = false;
    openFirewall = true;
  };

  services.wivrn = {
    enable = true;
    openFirewall = true;

    # Write information to /etc/xdg/openxr/1/active_runtime.json, VR applications
    # will automatically read this and work with WiVRn (Note: This does not currently
    # apply for games run in Valve's Proton)
    defaultRuntime = true;

    # Run WiVRn as a systemd service on startup
    autoStart = true;

    # Config for WiVRn (https://github.com/WiVRn/WiVRn/blob/master/docs/configuration.md)
    config = {
      enable = true;
      json = {
        # 1.0x foveation scaling
        scale = 1.0;
        # 100 Mb/s
        bitrate = 100000000;
        encoders = [
          {
            encoder = "vaapi";
            # codec = "h265";
            codec = "av1";
            # 1.0 x 1.0 scaling
            width = 1.0;
            height = 1.0;
            offset_x = 0.0;
            offset_y = 0.0;
          }
        ];
      };
    };
  };

  # Fixes issue with SteamVR not starting
  # system.activationScripts.fixSteamVR = "${lib.getExe' pkgs.libcap "setcap"} CAP_SYS_NICE+ep /home/${username}/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher";
}
