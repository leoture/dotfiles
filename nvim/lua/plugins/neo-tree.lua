return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  config = function()
    vim.keymap.set('n', '<C-n>', '<CMD>Neotree filesystem reveal<CR>', { desc = "[N]avigation" })
    require("neo-tree").setup({
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols", -- Optional, requires nvim 0.10+
      },
      window = {
        position = "float"
      },
      source_selector= {
        winbar = true
      },
      filesystem = {
        filtered_items = {
          visible = true
        }
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added     = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "M", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "D",-- this can only be used in the git_status source
            renamed   = "R",-- this can only be used in the git_status source
            -- Status type
            untracked = "/",
            ignored   = "#",
            unstaged  = "*",
            staged    = "=",
            conflict  = "<>",
          }
        },
        diagnostics = {
          symbols = {
            hint = "H",
            info = "I",
            warn = "W",
            error = "E",
          },
        }
      }
    })
  end
}
