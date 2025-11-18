{
  lib,
  # namespace,
  ...
}: let
  mkKeymapOpt = key: action: cfg:
    {
      key = key;
      action = action;
    }
    // cfg;
  mkKeymap = key: action: desc: {
    key = key;
    action = action;
    mode = ["n"];
    options = {
      silent = true;
      desc = desc;
    };
  };
in {
  common = {
    vscodeExternal = [
      {
        "key" = "ctrl+c";
        "command" = "-filesExplorer.copy";
        "when" = "filesExplorerFocus && foldersViewVisible && !explorerResourceIsRoot && !inputFocus";
      }
    ];
    vscode = {
      "vim.leader" = "<space>";
      "vim.normalModeKeyBindings" = [
        {
          before = [
            "<leader>"
            ":"
          ];
          commands = ["workbench.action.showCommands"];
        }
        {
          before = [
            "<leader>"
            "q"
          ];
          commands = [":xa"];
        }
        {
          before = ["<ESC>"];
          commands = [":nohl"];
        }
      ];
      "vim.visualModeKeyBindings" = [
        {
          before = [">"];
          commands = ["editor.action.indentLines"];
        }
        {
          before = ["<"];
          commands = ["editor.action.outdentLines"];
        }
      ];
      "vim.visualModeKeyBindingsNonRecursive" = [
        # paste without overwriting current register
        {
          before = ["p"];
          after = [
            "p"
            "g"
            "v"
            "y"
          ];
        }
      ];
      "vim.insertModeKeyBindings" = [
        {
          before = [
            "j"
            "k"
          ];
          after = ["<ESC>"];
        }
        {
          before = [
            "j"
            "j"
          ];
          after = ["<ESC>"];
        }
      ];
      "vim.handleKeys" = {
        "<C-a>" = false;
        "<C-f>" = false;
      };
    };
    nixvim = [
      {
        action = "<cmd>xa<cr>";
        key = "<leader>q";
        mode = "n";
        options = {
          silent = true;
          nowait = true;
          desc = "󰸧 Save and close";
        };
      }
      {
        action = "<cmd>nohlsearch<cr>";
        key = "<esc>";
        mode = "n";
        options = {
          silent = true;
          nowait = true;
        };
      }
      # {
      #   mode = "i";
      #   key = "jk";
      #   action = "<esc>";
      #   options = {
      #     silent = true;
      #     nowait = true;
      #     desc = "Escape";
      #   };
      # }
      # {
      #   mode = "i";
      #   key = "jj";
      #   action = "<esc>";
      #   options = {
      #     silent = true;
      #     nowait = true;
      #     desc = "Escape";
      #   };
      # }
      {
        mode = "n";
        key = "<leader>sr";
        action = "<cmd>Telescope oldfiles<cr>";
        options = {
          silent = true;
          nowait = true;
          desc = "Telescope oldfiles";
        };
      }
      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>Telescope live_grep<cr>";
        options = {
          silent = true;
          nowait = true;
          desc = "Telescope grep";
        };
      }

      {
        mode = "n";
        key = "<leader>sg";
        action = "<cmd>Telescope live_grep<cr>";
        options = {
          silent = true;
          nowait = true;
          desc = "Telescope find_files";
        };
      }
    ];
  };
  wincmd = {
    vscode = {
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = [
            "<leader>"
            "w"
            "r"
          ];
          "commands" = ["workbench.action.evenEditorWidths"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "w"
          ];
          "commands" = ["workbench.action.increaseViewWidth"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "n"
          ];
          "commands" = ["workbench.action.decreaseViewWidth"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "t"
          ];
          "commands" = ["workbench.action.increaseViewHeight"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "s"
          ];
          "commands" = ["workbench.action.decreaseViewHeight"];
        }
        {
          "before" = [
            "<leader>"
            "<tab>"
          ];
          "commands" = ["workbench.action.nextEditorInGroup"];
        }
        {
          "before" = [
            "<leader>"
            "<S-tab>"
          ];
          "commands" = ["workbench.action.previousEditorInGroup"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "h"
          ];
          "commands" = ["workbench.action.focusLeftGroupWithoutWrap"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "l"
          ];
          "commands" = ["workbench.action.focusRightGroupWithoutWrap"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "k"
          ];
          "commands" = ["workbench.action.focusAboveGroupWithoutWrap"];
        }
        {
          "before" = [
            "<leader>"
            "w"
            "j"
          ];
          "commands" = ["workbench.action.focusBelowGroupWithoutWrap"];
        }
      ];
    };
    vscodeExternal = [
      {
        "key" = "ctrl+k ctrl+pagedown";
        "command" = "-workbench.action.nextEditorInGroup";
      }
      {
        "key" = "ctrl+k ctrl+pagedup";
        "command" = "-workbench.action.previousEditorInGroup";
      }
      {
        "key" = "ctrl+tab";
        "command" = "-workbench.action.quickOpenNavigateNextInEditorPicker";
        "when" = "inEditorsPicker && inQuickOpen";
      }
      {
        "key" = "ctrl+shift+tab";
        "command" = "-workbench.action.quickOpenNavigatePreviousInEditorPicker";
        "when" = "inEditorsPicker && inQuickOpen";
      }
      {
        "key" = "ctrl+tab";
        "command" = "workbench.action.nextEditorInGroup";
      }
      {
        "key" = "ctrl+shift+tab";
        "command" = "workbench.action.previousEditorInGroup";
      }
      {
        "key" = "ctrl+shift+tab";
        "command" = "-workbench.action.quickOpenLeastRecentlyUsedEditorInGroup";
        "when" = "!activeEditorGroupEmpty";
      }
      {
        "key" = "ctrl+tab";
        "command" = "-workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup";
        "when" = "!activeEditorGroupEmpty";
      }
    ];
    nixvim = [
      {
        action = "<cmd>wincmd h<cr>";
        key = "<C-h>";
        mode = "n";
        options = {
          silent = true;
        };
      }

      {
        action = "<cmd>wincmd l<cr>";
        key = "<C-l>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>wincmd k<cr>";
        key = "<C-k>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>wincmd j<cr>";
        key = "<C-j>";
        mode = "n";
        options = {
          silent = true;
        };
      }

      {
        action = "<cmd>wincmd h<cr>";
        key = "<leader>wh";
        mode = "n";
        options = {
          silent = true;
          desc = " Move To Left";
        };
      }
      {
        action = "<cmd>wincmd j<cr>";
        key = "<leader>wj";
        mode = "n";
        options = {
          silent = true;
          desc = " Move To Down";
        };
      }
      {
        action = "<cmd>wincmd k<cr>";
        key = "<leader>wk";
        mode = "n";
        options = {
          silent = true;
          desc = " Move to Up";
        };
      }
      {
        action = "<cmd>wincmd l<cr>";
        key = "<leader>wl";
        mode = "n";
        options = {
          silent = true;
          desc = " Move To Right";
        };
      }

      {
        action = "<cmd>bnext<cr>";
        key = "<S-l>";
        mode = "n";
        options = {
          silent = true;
        };
      }
      {
        action = "<cmd>bprev<cr>";
        key = "<S-h>";
        mode = "n";
        options = {
          silent = true;
        };
      }
    ];
  };
  searching = {
    vscode = {
      "vim.visualModeKeyBindingsNonRecursive" = [];
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          before = [
            "<leader>"
            "e"
          ];
          commands = ["workbench.view.explorer"];
        }
        {
          before = [
            "<leader>"
            "s"
          ];
          commands = ["workbench.view.search"];
          when = ["workbench.view.search.active && neverMatch =~ /doesNotMatch/"];
        }
      ];
      "vim.normalModeKeyBindings" = [
        {
          before = [
            "<leader>"
            "f"
            "f"
          ];
          commands = ["workbench.action.quickOpen"];
          when = ["!editorFocus"];
        }
      ];
    };
    vscodeExternal = [
      {
        key = "space f f"; # chores
        command = "workbench.action.quickOpen";
        when = "!editorTextFocus && !inputFocus && !inQuickOpen";
      }
      {
        key = "cmd+p";
        command = "-workbench.action.quickOpen";
      }
      {
        key = "ctrl+p";
        command = "-workbench.action.quickOpen";
      }
      {
        key = "Tab";
        command = "quickInput.next";
        when = "inQuickInput && quickInputType == 'quickPick'";
      }
      {
        key = "space e";
        command = "runCommands";
        when = "!editorFocus && !inputFocus && viewContainer.workbench.view.explorer.enabled && explorerViewletVisible";
        args = {
          commands = [
            "workbench.files.action.focusFilesExplorer"
          ];
        };
      }
      {
        key = "space e";
        command = "runCommands";
        when = "!editorFocus && !inputFocus && viewContainer.workbench.view.explorer.enabled && explorerViewletVisible && explorerViewletFocus";
        args = {
          commands = [
            "workbench.action.closeSidebar"
          ];
        };
      }
      {
        key = "shift+cmd+e";
        command = "-workbench.view.explorer";
        when = "viewContainer.workbench.view.explorer.enabled";
      }
      {
        key = "h";
        command = "previousCompressedFolder";
        when = "explorerViewletCompressedFocus && filesExplorerFocus && foldersViewVisible && !explorerViewletCompressedFirstFocus && !inputFocus";
      }
      {
        key = "l";
        command = "nextCompressedFolder";
        when = "explorerViewletCompressedFocus && filesExplorerFocus && foldersViewVisible && !explorerViewletCompressedLastFocus && !inputFocus";
      }
      {
        key = "a";
        command = "explorer.newFile";
        when = "explorerViewletFocus && !inputFocus && viewContainer.workbench.view.explorer.enabled";
      }
      {
        key = "ctrl+v";
        command = "runCommands";
        args = {
          commands = [
            "explorer.openToSide"
          ];
        };
        when = "explorerViewletFocus && foldersViewVisible && !inputFocus";
      }
      {
        key = "ctrl+enter";
        command = "-explorer.openToSide";
        when = "explorerViewletFocus && foldersViewVisible && !inputFocus";
      }
      {
        key = "ctrl+enter";
        command = "-explorer.openToSide";
        when = "explorerViewletFocus && foldersViewVisible && !inputFocus";
      }
    ];
    nixvim = [
      # NvimTree
      (mkKeymap "<leader>e" "<cmd>Neotree reveal<cr>" "󰙅 Reveal in Explorer")

      # (mkKeymap "<leader><leader>" "<cmd>Neotree reveal<cr>" "󰙅 Toggle Explorer (Reveal)")
      (mkKeymap "\\" "<cmd>Neotree toggle<cr>" "󰙅 Toggle Explorer")
      # Spectre
      (mkKeymap "<leader>s" "<cmd>lua require('spectre').toggle()<cr>" " Search & Replace")
      (mkKeymapOpt "<leader>s" "<cmd>lua require('spectre').open_visual()<cr>" {
        mode = ["v"];
        options = {
          silent = true;
          noremap = true;
          nowait = true;
          desc = " Search & Replace";
        };
      })
      # Telescope
      (mkKeymap "<leader>ff" "<cmd>Telescope find_files<cr>" " Find File")
      (mkKeymap "<leader><leader>" "<cmd>Telescope find_files<cr>" " Find File")
      # live grep fs
      (mkKeymap "<leader>fs" "<cmd>Telescope live_grep<cr>" "󱄽 Search String")
      # live grep fs in visual mode
      (mkKeymapOpt "<leader>fs" "<cmd>lua _G.FUNCS.search_selected_text_in_visual_mode()<cr>" {
        mode = ["v"];
        options = {
          silent = true;
          noremap = true;
          nowait = true;
          desc = "󱄽 Search String";
        };
      })
      # buffers fb
      (mkKeymap "<leader>fb" "<cmd>Telescope buffers<cr>" " Buffers")
      # resume fr
      (mkKeymap "<leader>fe" "<cmd>Telescope resume<cr>" " R[e]sume")
      (mkKeymap "<leader>fr" "<cmd>Telescope oldfiles<cr>" " Recent")
      # help help
      (mkKeymap "<leader>fh" "<cmd>Telescope help_tags<cr>" "󰘥 Help")
      (mkKeymap "<leader>ft" "<cmd>TodoTrouble<cr>" " TODO")
      (mkKeymap "<leader>fi" "<cmd>Telescope nerdy<cr>" "󰲍 Icon picker")
    ];
  };
}
