{
  inputs,
  vars,
  gpuAcceleration,
  ...
}: {
  ## Not standalone. This is ment to be used alongside NixosModules

  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs vars gpuAcceleration;};
    backupFileExtension = "hm-back";
    users = {
      "${vars.user}" = import ../home/default.nix;
    };
  };
}
