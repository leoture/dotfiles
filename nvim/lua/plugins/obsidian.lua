return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    -- see below for full list of optional dependencies 👇
  },
  keys = {
    {"<leader>ov", "<CMD>ObsidianFollowLink vsplit<CR>", "[O]bsidian link [v]split"},
    {"<leader>oh", "<CMD>ObsidianFollowLink hsplit<CR>", "[O]bsidian link [h]split"},
    {"<leader>ot", "<CMD>ObsidianToday<CR>", "[O]bsidian [T]oday"},
    {"<leader>od", "<CMD>ObsidianDailies<CR>", "[O]bsidian [D]ailies"},
    {"<leader>on", "<CMD>ObsidianNew<CR>", "[O]bsidian [N]ew"},
    -- {
    --     "<leader>?",
    --     function()
    --         require("which-key").show({ global = false })
    --     end,
    --     desc = "Buffer Local Keymaps (which-key)",
    -- },
  },

  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "/Users/jordhanleoture/Notes",
      },
    },
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({"open", url})  -- Mac OS
    end,
  }
}
