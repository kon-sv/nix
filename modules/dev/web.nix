{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages = with pkgs; [
      nodejs_24

      php
      php84Packages.composer
      intelephense
    ];
  };
}
