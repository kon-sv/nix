{
  vars,
  pkgs,
  ...
}: {
  users.users.${vars.user} = {
    packages = with pkgs; [
      docker
    ];
    extraGroups = ["docker"];
  };

  environment.systemPackages = with pkgs; [
    docker
  ];
}
