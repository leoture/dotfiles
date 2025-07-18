return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons' ,
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local function harpoon_component()
      local Path = require("plenary.path")
      local harpoon = require("harpoon")
      local total_marks = harpoon:list():length()
      if total_marks == 0 then
        return ""
      end

      local current_mark = "—"
      local current_buffer = vim.api.nvim_get_current_buf()
      local current_buffer_name = vim.api.nvim_buf_get_name(current_buffer)
      local value = Path:new(current_buffer_name):make_relative(harpoon:list().config.get_root_dir())

      local _, mark_idx = harpoon:list():get_by_value(value)
      if mark_idx ~= nil then
        current_mark = tostring(mark_idx)
      end

      return string.format("󱡅 %s/%d", current_mark, total_marks)
    end

    local function copilot_status()
      if vim.g.copilot_enabled == 1 then
        return ""  -- Nerd Font Copilot icon
      end
      return ""
    end

    local function treesitter_status()
      local statusline = require("nvim-treesitter").statusline({
        indicator_size = 100,
        type_patterns = { "class", "function", "method" },
        separator = " | ",
      })
      return statusline == nil and "" or statusline
    end

    local lazy_status = require('lazy.status')

    local pallet = require('catppuccin.palettes').get_palette()

    local primaryColor = "#ff9e64"

    require('lualine').setup({
      options = {
        component_separators = '',
        section_separators = ' ',
        theme = {
          normal = {
            a = { bg = pallet.mantle, fg = pallet.text },
            b = { bg = pallet.mantle, fg = pallet.text },
            c = { bg = pallet.mantle, fg = pallet.text },
            x = { bg = pallet.mantle, fg = pallet.text },
            y = { bg = pallet.mantle, fg = primaryColor },
            z = { bg = pallet.blue, fg = pallet.mantle, gui = 'bold' },
          },
          insert = {
            a = { bg = pallet.mantle, fg = pallet.text },
            b = { bg = pallet.mantle, fg = pallet.text },
            c = { bg = pallet.mantle, fg = pallet.text },
            x = { bg = pallet.mantle, fg = pallet.text },
            y = { bg = pallet.mantle, fg = primaryColor },
            z = { bg = pallet.green, fg = pallet.mantle, gui = 'bold' },
          },
          visual = {
            a = { bg = pallet.mantle, fg = pallet.text },
            b = { bg = pallet.mantle, fg = pallet.text },
            c = { bg = pallet.mantle, fg = pallet.text },
            x = { bg = pallet.mantle, fg = pallet.text },
            y = { bg = pallet.mantle, fg = primaryColor },
            z = { bg = pallet.mauve, fg = pallet.mantle, gui = 'bold' },
          },
          replace = {
            a = { bg = pallet.mantle, fg = pallet.text },
            b = { bg = pallet.mantle, fg = pallet.text },
            c = { bg = pallet.mantle, fg = pallet.text },
            x = { bg = pallet.mantle, fg = pallet.text },
            y = { bg = pallet.mantle, fg = primaryColor },
            z = { bg = pallet.red, fg = pallet.mantle, gui = 'bold' },
          },
          command = {
            a = { bg = pallet.mantle, fg = pallet.text },
            b = { bg = pallet.mantle, fg = pallet.text },
            c = { bg = pallet.mantle, fg = pallet.text },
            x = { bg = pallet.mantle, fg = pallet.text },
            y = { bg = pallet.mantle, fg = primaryColor },
            z = { bg = pallet.peach, fg = pallet.mantle, gui = 'bold' },
          },
          inactive = {
            a = { bg = pallet.mantle, fg = pallet.text },
            b = { bg = pallet.mantle, fg = pallet.text },
            c = { bg = pallet.mantle, fg = pallet.text },
            x = { bg = pallet.mantle, fg = pallet.text },
            y = { bg = pallet.mantle, fg = primaryColor },
            z = { bg = pallet.overlay1, fg = pallet.mantle, gui = 'bold' },
          }
        }
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            buffers_color = {
              active = { fg = pallet.mantle, bg = primaryColor },
              inactive = { fg = primaryColor, bg = pallet.mantle }
            },
          },
        },
        lualine_z = {
          {
            'tabs',
            tabs_color = {
            active = { fg = pallet.mantle, bg = primaryColor },
            inactive = { fg = primaryColor, bg = pallet.mantle}
            },
          },
        }
      },
      winbar = {
        lualine_a = {
          {
            treesitter_status,
            color = { fg = pallet.teal, bg = pallet.mantle },
          }
        },
      },
      sections = {
        lualine_a = {
          'branch',
          'diff',
        },
        lualine_b = {
          'diagnostics',
        },
        lualine_c = {},
        lualine_y = {
          harpoon_component,
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          copilot_status,
        },
        lualine_z = {
          {
            'searchcount',
            padding = { left = 1, right = 0 }
          },
          {
            'progress',
            padding = { left = 1, right = 0 }
          },
          {
            'location',
          },
          {
            'mode',
            fmt = function(str)
              return str:sub(1, 1)
            end,
            padding = { left = 0, right = 1 }
          }
        },
      }
    })
  end
}
