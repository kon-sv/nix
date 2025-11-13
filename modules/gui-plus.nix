{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages = with pkgs; [
      qbittorrent-enhanced
      filezilla

      # chat
      viber
      telegram-desktop
      caprine

      discord-ptb
      yt-dlp
      mpv

      kitty-themes
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
