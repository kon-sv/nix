{
  pkgs,
  lib,
  ...
}: {
  enable = true;
  colorschemes.catppuccin.enable = true;
  diagnostic.settings = {
    float = {border = "rounded";};
    virtual_lines = {current_line = true;};
    virtual_text = true;
    signs = true;
    underline = true;
    update_in_insert = false;
  };
  autoGroups = {builtin_auto_completion = {clear = true;};};
  globals = {
    mapleader = " ";
    maplocalleader = "\\";
    loaded_netrw = 1;
    loaded_netrwPlugin = 1;
  };
  plugins = {
    mini = {
      enable = true;
      modules = {
        tabline = {
          show_icons = true;
          format = null;
          tabpage_section = "left";
        };
      };
    };
    gitgutter.enable = true;
    lualine.enable = true;
    telescope.enable = true;
    neo-tree.enable = true;
    nix.enable = true;

    neogit.enable = true;

    #debug
    dap.enable = true;
    dap-ui.enable = false;

    lazy.enable = true;
    blink-cmp = {
      enable = true;
      settings.sources.providers = {
        git = {
          module = "blink-cmp-git";
          name = "git";
          score_offset = 100;
          opts = {
            commit = {};
            git_centers = {git_hub = {};};
          };
        };

        dictionary = {
          module = "blink-cmp-dictionary";
          name = "Dict";
          score_offset = 100;
          min_keyword_length = 3;
          # Optional configurations
          opts = {
          };
        };

        ripgrep = {
          async = true;
          module = "blink-ripgrep";
          name = "Ripgrep";
          score_offset = 100;
          opts = {
            prefix_min_len = 3;
            context_size = 5;
            max_filesize = "1M";
            project_root_marker = ".git";
            project_root_fallback = true;
            search_casing = "--ignore-case";
            additional_rg_options = {};
            fallback_to_regex_highlighting = true;
            ignore_paths = {};
            additional_paths = {};
            debug = false;
          };
        };
      };
    };

    comment.enable = true;
    treesitter = {
      enable = true;
      settings = {
        highlight = {enable = true;};
        indent = {enable = true;};
      };
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        nix
        regex
        toml
        vim
        vimdoc
        xml
        yaml
      ];
    };

    ## From circus-nix
    lspsaga = {enable = true;};
    # https://gpanders.com/blog/whats-new-in-neovim-0-11/#more-default-mappings
    # grn in Normal mode maps to vim.lsp.buf.rename()
    # grr in Normal mode maps to vim.lsp.buf.references()
    # gri in Normal mode maps to vim.lsp.buf.implementation()
    # gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
    # gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
    # CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()
    # [d and ]d move between diagnostics in the current buffer ([D jumps to the first diagnostic, ]D jumps to the last)
    lsp = {
      enable = true;
      keymaps = {
        diagnostic = {
          "]e" = "goto_next";
          "[e" = "goto_prev";
        };
        # lspBuf = {
        #   gD = "references";
        #   gd = "definition";
        #   gi = "implementation";
        #   gt = "type_definition";
        # };
        extra = [
          {
            action = "<cmd>Lspsaga hover_doc<cr>";
            key = "K";
          }
          {
            action = "<cmd>lua vim.lsp.buf.format({ async = true })<cr>";
            key = "<leader>lF";
          }
          {
            action = "<cmd>Lspsaga goto_type_definition<cr>";
            key = "<leader>lD";
          }
          # gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
          {
            action = "<cmd>Lspsaga code_action<cr>";
            key = "<leader>la";
          }
          {
            action = "<cmd>Lspsaga goto_definition<cr>";
            key = "<leader>ld";
          }
          # grr in Normal mode maps to vim.lsp.buf.references()
          {
            action = "<cmd>Lspsaga finder<cr>";
            key = "<leader>lf";
          }
          {
            action = "<cmd>Lspsaga finder<cr>";
            key = "grr";
          }
          # gO in Normal mode maps to vim.lsp.buf.document_symbol() (this is analogous to the gO mappings in help buffers and :Man page buffers to show a “table of contents”)
          {
            action = "<cmd>Telescope lsp_document_symbols<cr>";
            key = "<leader>lo";
          }
          # grn in Normal mode maps to vim.lsp.buf.rename()
          {
            action = "<cmd>Lspsaga rename mode=n<cr>";
            key = "<leader>lr";
          }
          {
            action = "<cmd>Lspsaga rename mode=n<cr>";
            key = "grn";
          }
        ];
      };
      servers = {
        ts_ls.enable = true;
        volar.enable = true;
        phpactor.enable = true;
        rust_analyzer = {
          # not very nix-like of me but I like `rustup`
          installCargo = false;
          installRustc = false;

          enable = true;
        };
        pylyzer = {
          enable = false;
        };
        pyright.enable = true;
        nil_ls = {
          enable = true;
          settings = {
            formatting.command = ["${lib.getExe pkgs.alejandra}"];
            nix.flake.autoArchive = true;
          };

          # extraOptions.settings = { formatting.command = "nixfmt"; };
        };
      };
    };

    which-key = {
      enable = true;
      settings = {
        icons.mappings = false;
        icons.separator = " ";
        icons.group = " ";
        preset = "modern";
        delay = 0;
        show_help = false;
      };
    };

    conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
      };
    };

    ## Editor Styling, Styles, UI plugins
    transparent.enable = true;
    fidget = {enable = true;};
    colorizer.enable = true;
    web-devicons.enable = true;
    todo-comments.enable = true;

    ## end plugins
  };

  keymaps = let
    inherit
      (import ./keybinds.nix {inherit lib;})
      common
      wincmd
      searching
      ;
  in
    lib.concatLists [common.nixvim wincmd.nixvim searching.nixvim];
  editorconfig.enable = true;
  clipboard.register = "unnamedplus";
  performance = {
    byteCompileLua = {
      enable = false;
      nvimRuntime = true;
      configs = true;
      plugins = true;
    };
  };
  opts = {
    timeout = true;
    autowrite = true;
    clipboard = "unnamedplus";
    completeopt = "menu,noinsert,popup,fuzzy";
    conceallevel = 3;
    confirm = true;
    cursorline = true;
    expandtab = true;
    formatoptions = "jcroqlnt";
    grepformat = "%f:%l:%c:%m";
    grepprg = "rg --vimgrep";
    ignorecase = true;
    inccommand = "nosplit";
    laststatus = 3;
    list = true;
    mouse = "a";
    number = true;
    pumblend = 10;
    pumheight = 10;
    relativenumber = false;
    scrolloff = 4;
    shiftround = true;
    shiftwidth = 2;
    showmode = false;
    sidescrolloff = 8;
    signcolumn = "yes";
    smartcase = true;
    smartindent = true;
    splitbelow = true;
    splitkeep = "screen";
    splitright = true;
    tabstop = 2;
    termguicolors = true;
    timeoutlen = 500;
    undofile = true;
    undolevels = 10000;
    # updatetime = 200;
    virtualedit = "block";
    wildmode = "longest:full,full";
    winminwidth = 5;
    wrap = true;
    winborder = "rounded";
  };
}
