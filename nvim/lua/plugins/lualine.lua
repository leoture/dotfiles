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

    -- Define Copilot status component
    local function copilot_status()
      if vim.g.copilot_enabled == 1 then
        return ""  -- Nerd Font Copilot icon
      end
      return ""
    end
    require('lualine').setup({
      options = {
        --theme = 'catppuccin'
        theme = 'rose-pine',
      },
      sections = {
        lualine_b = {
          'branch',
          'diff',
          {
            'diagnostics',
            -- Table of diagnostic sources, available sources are:
            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
            -- or a function that returns a table as such:
            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
            sources = { 'nvim_diagnostic', 'coc', 'nvim_lsp' },

            -- Displays diagnostics for the defined severity types
            sections = { 'error', 'warn', 'info', 'hint' },

            diagnostics_color = {
              -- Same values as the general color option can be used here.
              error = 'DiagnosticError', -- Changes diagnostics' error color.
              warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
              info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
              hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
            },
            symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
            colored = true,           -- Displays diagnostics status in color if set to true.
            update_in_insert = true, -- Update diagnostics in insert mode.
            always_visible = true,   -- Show diagnostics even if there are none.
          }
        },
        lualine_c = {
          { 'filename', path = 1 },
          harpoon_component
        },
        lualine_x = {
          'encoding',
          'fileformat',
          'filetype',
          copilot_status,  -- Add Copilot status component
        },
      }
    })
  end
}
