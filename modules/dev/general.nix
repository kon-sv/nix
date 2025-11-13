{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}: {
  users.users.${vars.user} = {
    packages =
      (with pkgs; [
        #androidenv.androidPkgs_9_0.platform-tools
        bison
        curl
        flex
        git
        gitRepo
        gh
        gnumake
        gnupg
        gperf
        jdk
        libxml2
        lzop
        m4
        ncurses5
        nettools
        openssl
        perl
        procps
        #python2
        python3
        rustfmt
        rustup
        gcc
        clang
        libclang
        schedtool
        scrcpy
        thonny
        unzip
        util-linux
        zip
        zlib
      ])
      ++ (with pkgs-unstable; [
        android-studio
        #ladybird
      ]);
    extraGroups = ["kvm" "adbusers" "dialout"];
  };

  programs.adb.enable = true;

  environment.variables = {
    LIBCLANG_PATH = "";
  };
}
