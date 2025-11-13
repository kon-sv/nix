let
  homepath = "/home/konsv";
  flakepath = "${homepath}/nix";
in
  {
    config,
    pkgs,
    lib,
    onGui ? true,
    ...
  }:
    {
      home.username = "konsv";
      home.homeDirectory = homepath;

      nixpkgs.config.allowUnfreePredicate = _: true;

      # This value determines the Home Manager release that your configuration is
      # compatible with. This helps avoid breakage when a new Home Manager release
      # introduces backwards incompatible changes.
      #
      # You should not change this value, even if you update Home Manager. If you do
      # want to update the value, then make sure to first check the Home Manager
      # release notes.
      home.stateVersion = "25.05"; # Please read the comment before changing.

      home.packages = with pkgs;
        [
          hello
          tmux
          ripgrep
          yt-dlp

          # # It is sometimes useful to fine-tune packages, for example, by applying
          # # overrides. You can do that directly here, just don't forget the
          # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
          # # fonts?
          # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

          # # You can also create simple shell scripts directly inside your
          # # configuration. For example, this adds a command 'my-hello' to your
          # # environment:
          # (pkgs.writeShellScriptBin "my-hello" ''
          #   echo "Hello, ${config.home.username}!"
          # '')
        ]
        ++ (
          if onGui
          then with pkgs; [
            mpv
            discord-ptb
            spotify
            krita
          ]
          else []
        );

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      home.file = {
        # # Building this configuration will create a copy of 'dotfiles/screenrc' in
        # # the Nix store. Activating the configuration will then make '~/.screenrc' a
        # # symlink to the Nix store copy.
        # ".screenrc".source = dotfiles/screenrc;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
      };

      # Home Manager can also manage your environment variables through
      # 'home.sessionVariables'. These will be explicitly sourced when using a
      # shell provided by Home Manager. If you don't want to manage your shell
      # through Home Manager then you have to manually source 'hm-session-vars.sh'
      # located at either
      #
      #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  /etc/profiles/per-user/nixos/etc/profile.d/hm-session-vars.sh
      #
      home.sessionVariables = {
        EDITOR = "nvim";
      };

      xsession.windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        config = {
          modifier = "Mod4";
          gaps = {
            inner = 10;
            outer = 5;
          };
        };
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;

      programs = {
        nixvim = import ./nixvim.nix;
        zsh = {enable = true;};

        kitty = {
          enable = onGui;
          font = {
            size = 12;
            name = "DejaVu Sans";
          };
          themeFile = "ayu";
          extraConfig = ''
            window_margin_width 20
            background_opacity 0.50
            background_blur 1
          '';
        };

        starship = {enable = true;};

        wezterm = {
          # on enable this adds a wezterm.sh source in .zshrc which slows the hell out of the shell
          enable = onGui;
          extraConfig = ''
            -- Your lua code / config here
            -- local mylib = require 'mylib';
            return {
             -- usemylib = mylib.do_fun();
              font = wezterm.font("JetBrains Mono"),
              font_size = 12.0,
              -- color_scheme = "Tomorrow Night",
              color_scheme = "catppuccin-macchiato",

              hide_tab_bar_if_only_one_tab = true,
              default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" },
              keys = {
                {key="n", mods="SHIFT|CTRL", action="ToggleFullScreen"},
              },

              -- front_end = "WebGpu"
            }
          '';
        };

        tmux = {
          enable = true;
          mouse = true;
          secureSocket = false;
          baseIndex = 1;
          plugins = with pkgs; [
            tmuxPlugins.better-mouse-mode
            tmuxPlugins.tmux-powerline
            tmuxPlugins.yank
          ];
          extraConfig = ''
            set -g visual-activity off
            set -g visual-bell off
            set -g visual-silence off
            setw -g monitor-activity off
            set -g bell-action none

            # clock mode
            setw -g clock-mode-colour yellow

            # copy mode
            setw -g mode-style 'fg=black bg=red bold'

            # panes
            set -g pane-border-style 'fg=red'
            set -g pane-active-border-style 'fg=yellow'

            # statusbar
            set -g status-position bottom
            set -g status-justify left
            set -g status-style 'fg=red'

            set -g status-left ""
            set -g status-left-length 10

            set -g status-right-style 'fg=black bg=yellow'
            set -g status-right '%Y-%m-%d %H:%M '
            set -g status-right-length 50

            setw -g window-status-current-style 'fg=black bg=red'
            setw -g window-status-current-format ' #I #W #F '

            setw -g window-status-style 'fg=red bg=black'
            setw -g window-status-format ' #I #[fg=white]#W #[fg=yellow]#F '

            setw -g window-status-bell-style 'fg=yellow bg=red bold'

            # messages
            set -g message-style 'fg=yellow bg=red bold'


            bind-key -r -T prefix       M-Up              resize-pane -U 5
            bind-key -r -T prefix       M-Down            resize-pane -D 5
            bind-key -r -T prefix       M-Left            resize-pane -L 5
            bind-key -r -T prefix       M-Right           resize-pane -R 5
            bind-key -r -T prefix       C-Up              resize-pane -U
            bind-key -r -T prefix       C-Down            resize-pane -D
            bind-key -r -T prefix       C-Left            resize-pane -L
            bind-key -r -T prefix       C-Right           resize-pane -R
          '';
        };

        nh = {
          enable = true;
          clean.enable = true;
          # clean.extraArgs = "--keep-since 4d --keep 3";
          flake = flakepath;
        };
      };
    }
    // (
      if onGui
      then {
        imports = [];

        # suggested in https://lvra.gitlab.io/docs/distros/nixos/
        # but not sure how it helps
        xdg.configFile."openvr/openvrpaths.vrpath".text = ''
          {
            "config" :
            [
              "~/.local/share/Steam/config"
            ],
            "external_drivers" : null,
            "jsonid" : "vrpathreg",
            "log" :
            [
              "~/.local/share/Steam/logs"
            ],
            "runtime" :
            [
              "${pkgs.opencomposite}/lib/opencomposite"
            ],
            "version" : 1
          }
        '';
      }
      else {}
    )
