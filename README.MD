# Description

NixOS configuration used by my main PC (aka ayame).

Most of the stuff I want to include are part of a `module` and activate them in `hosts/ayame/configuration.nix`.

Not every module is my own and most of them I haven't ever used. I am keeping them for reference and until I better understand what they do.

# Help

### OS
Rebuild NixOS with `sudo nixos-rebuild switch --flake .`

### Home
Set home files with home-manager by running  `home-manager switch --flake .`
