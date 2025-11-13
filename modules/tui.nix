{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  nixpkgs.overlays = [
    (import ../overlays/weechat.nix)
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];
  users.users.${vars.user} = {
    packages = with pkgs; [
      # chat
      weechat
    ];
  };
}
