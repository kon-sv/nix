self: super: {
  weechat = super.weechat.override {
    configure = {availablePlugins, ...}: {
      scripts = with super.weechatScripts; [
        # weechat-otr
        # wee-slack
        weechat-matrix
      ];
      # Uncomment this if you're on Darwin, there's no PHP support available. See https://github.com/NixOS/nixpkgs/blob/e6bf74e26a1292ca83a65a8bb27b2b22224dcb26/pkgs/applications/networking/irc/weechat/wrapper.nix#L13 for more info.
      # plugins = builtins.attrValues (builtins.removeAttrs availablePlugins [ "php" ]);
    };
  };
}
