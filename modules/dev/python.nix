{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages =
      (with pkgs; [
        python310
        poetry
      ])
      ++ (with pkgs-unstable; [
        ]);
    extraGroups = ["kvm" "adbusers" "dialout"];
  };

  programs.adb.enable = true;
}
