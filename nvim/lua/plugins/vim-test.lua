return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  config = function()
    vim.g['test#strategy'] = 'neovim'
    vim.g['neoterm_default_mod'] = 'botright'
    vim.g['test#neovim#start_normal'] = 1
  end
}
-- return {
--   "nvim-neotest/neotest",
--   dependencies = {
--     "nvim-neotest/nvim-nio",
--     "nvim-lua/plenary.nvim",
--     "antoinemadec/FixCursorHold.nvim",
--     "nvim-treesitter/nvim-treesitter",
--     "mmllr/neotest-swift-testing",
--   },
--   config = function()
--     require("neotest").setup({
--       adapters = {
--         require("neotest-swift-testing")
--       },
--     })
--   end,
-- }
