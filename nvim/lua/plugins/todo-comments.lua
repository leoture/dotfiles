return {
    "folke/todo-comments.nvim",
    event = 'VimEnter',
    dependencies = { "nvim-lua/plenary.nvim" },
    config= function()
        local todo_comments = require("todo-comments")
        todo_comments.setup()
    end,
}

