return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "c", "regex", "lua", "vim", "vimdoc", "swift", "css", "javascript", "html", "xml", "ruby", "bash", "markdown", "markdown_inline" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}
