return {
    "folke/todo-comments.nvim",
    event = 'VimEnter',
    dependencies = { "nvim-lua/plenary.nvim" },
    config= function()
        local todo_comments = require("todo-comments")
        todo_comments.setup()
    end,
    keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [t]odo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "[S]earch [T]odo/Fix/Fixme" },
  },
}

