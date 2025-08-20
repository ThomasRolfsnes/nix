{ config, pkgs, ... }: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };

        visuals = {
          nvim-cursorline.enable = true;
        };

        statusline.lualine.enable = true;
        autocomplete.nvim-cmp.enable = true;
        viAlias = true;
        vimAlias = true;

        # telescope config
        telescope.enable = true;
        telescope.mappings.findFiles = "<leader>p";
        telescope.mappings.liveGrep = "<leader>P";
        telescope.mappings.buffers = "<leader>b";

        extraPlugins = with pkgs.vimPlugins; {
          oil = {
            package = oil-nvim;
            setup = ''
                      require('oil').setup {
                        view_options = {
                          -- Show files and directories that start with "."
                          show_hidden = true
                        }
                      }
                    '';
          };
          mini-icons.package = mini-icons;
          web-devicons.package = nvim-web-devicons;
        };

        lsp = {
          enable = true;
        };

        languages = {
          enableTreesitter = true;
          python.enable = true;
          nix.enable = true;
          sql.enable = true;
        };

        globals.mapleader = ",";
        keymaps = [
           {key = "jk";
            mode = "i";
            silent = true;
            action = "<esc>";}
           {key = "<leader>n";
            mode = "n";
            silent = false;
            action = "<CMD>Oil<CR>";}
           {key = "<leader>f";
            mode = "n";
            silent = true;
            action = "<CMD>Telescope grep_string<CR>";}
        ];

        terminal = {
          toggleterm = {
            enable = true;
            mappings.open = "<leader>t";
            lazygit.enable = true;
            lazygit.mappings.open = "<leader>fg";
          };
        };

        comments.comment-nvim = {
          enable = true;
        };

        utility = {
          surround.enable = true;
          surround.useVendoredKeybindings = false;
        };

        # various options
        searchCase = "smart";
        options = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };
      };
    };
  };
}
