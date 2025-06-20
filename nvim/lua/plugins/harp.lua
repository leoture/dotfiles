return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  keys = function()
    local harpoon = require("harpoon")
    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end
      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end


    return {
      -- Harpoon marked files 1 through 4
      {"<leader>1", function() harpoon:list():select(1) end, desc ="Harpoon buffer [1]"},
      {"<leader>2", function() harpoon:list():select(2) end, desc ="Harpoon buffer [2]"},
      {"<leader>3", function() harpoon:list():select(3) end, desc ="Harpoon buffer [3]"},
      {"<leader>4", function() harpoon:list():select(4) end, desc ="Harpoon buffer [4]"},

      -- Harpoon next and previous.
      {"<leader>mn", function() harpoon:list():next() end, desc ="Harpoon [M]ark [N]ext"},
      {"<leader>mp", function() harpoon:list():prev() end, desc ="Harpoon [M]ark [P]revious"},

      -- Harpoon user interface.
      {"<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc ="[H]arpoon Toggle [M]enu"},
      {"<leader>ma", function() harpoon:list():add() end, desc ="Harpoon [M]ark [A]dd file"},
      {"<leader>mc", function() harpoon:list():clear() end, desc ="Harpoon [M]ark [C]lear"},
      {"<leader>md", function() harpoon:list():remove() end, desc ="Harpoon [M]ark [D]elete"},

      -- Use Telescope as Harpoon user interface.
      {"<leader>sm", function() toggle_telescope(harpoon:list() )end, desc ="Harpoon [S]earch [M]ark"},
    }
  end,
  config = function(_, opts)
    require("harpoon").setup(opts)
  end
}
