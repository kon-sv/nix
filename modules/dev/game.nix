{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages = with pkgs; [
      godot
    ];
  };
}
