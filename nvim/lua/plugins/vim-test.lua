return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux"
  },
  keys = {
    { "<leader>T", "<CMD>TestSuite<CR>", "Run tests" }
  }, 
  config = function()
    vim.cmd('let test#strategy = "vimux"')
  end
}
