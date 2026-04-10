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
                        },
                        keymaps = {
                          ["<C-q>"] = { "actions.add_to_qflist", mode = "n" },
                          ["<C-f>"] = {
                              callback = function()
                                  require("telescope.builtin").live_grep({
                                      cwd = require("oil").get_current_dir(),
                                  })
                              end,
                              desc = "Telescope Live Grep in current Oil dir",
                          },
                        }
                      }
                    '';
          };
          mini-icons.package = mini-icons;
          web-devicons.package = nvim-web-devicons;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        formatter.conform-nvim = {
          enable = true;
          setupOpts = {
            format_on_save = {
              timeout_ms = 5000;
              lsp_fallback = true;
            };
            formatters_by_ft = {
              python = [ "ruff_format" ];
            };
          };
        };

        languages = {
          enableTreesitter = true;
          python.enable = true;
          nix.enable = true;
          sql.enable = false;
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
           {key = "<leader>d";
            mode = "n";
            silent = true;
            action = "<CMD>Telescope lsp_definitions<CR>";}
           {key = "<leader>r";
            mode = "n";
            silent = true;
            action = "<CMD>Telescope lsp_references<CR>";}
           {key = "<leader>f";
            mode = "n";
            silent = true;
            action = "<CMD>Telescope lsp_document_symbols<CR>";}
        ];

        terminal = {
          toggleterm = {
            enable = true;
            mappings.open = "<leader>t";
            lazygit.enable = false;  # Using custom lazygit with worktree support
          };
        };

        luaConfigRC.lazygit-worktree = entryAnywhere ''
          local Terminal = require('toggleterm.terminal').Terminal
          local lazygit_newdir = vim.fn.expand("~/.lazygit/newdir")
          local lazygit_term = nil

          local function lazygit_toggle()
            -- Always create a fresh terminal with the current directory
            if lazygit_term then
              lazygit_term:shutdown()
            end
            lazygit_term = Terminal:new({
              cmd = "lazygit",
              hidden = true,
              direction = "float",
              dir = vim.fn.getcwd(),
              env = { LAZYGIT_NEW_DIR_FILE = lazygit_newdir },
              on_exit = function(term, job, exit_code, name)
                vim.schedule(function()
                  if vim.fn.filereadable(lazygit_newdir) == 1 then
                    local newdir = vim.fn.readfile(lazygit_newdir)[1]
                    vim.fn.delete(lazygit_newdir)
                    if newdir and newdir ~= vim.fn.getcwd() then
                      vim.api.nvim_set_current_dir(newdir)
                      vim.notify("Changed directory to: " .. newdir, vim.log.levels.INFO)
                    end
                  end
                  lazygit_term = nil
                end)
              end
            })
            lazygit_term:toggle()
          end

          vim.keymap.set("n", "<leader>fg", lazygit_toggle, { noremap = true, silent = true, desc = "Toggle Lazygit" })
        '';

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
