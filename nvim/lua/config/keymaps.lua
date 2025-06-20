local nnoremap     = require("config.keymaps-utils").nnoremap
local vnoremap     = require("config.keymaps-utils").vnoremap
local inoremap     = require("config.keymaps-utils").inoremap
local tnoremap     = require("config.keymaps-utils").tnoremap
local xnoremap     = require("config.keymaps-utils").xnoremap

-- Press 'U' for redo
nnoremap("U", "<C-r>")

nnoremap("<leader>q", vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vnoremap("J",          ":m '>+1<CR>gv=gv")
vnoremap("K",          ":m '<-2<CR>gv=gv")
nnoremap("n",          "nzzzv")
nnoremap("N",          "Nzzzv")
xnoremap("<leader>p",  [["_dP]])
nnoremap("<leader>y",  [["+y]])
nnoremap("<leader>Y",  [["+Y]])
vnoremap("<leader>y", [["+y]])
vnoremap("<leader>Y", [["+Y]])
-- nnoremap("n",         "<Esc>", ":nohlsearch<CR>")
-- nnoremap("<c-k>", "<CMD>wincmd k<CR>")
-- nnoremap("<c-j>", "<CMD>wincmd j<CR>")
-- nnoremap("<c-h>", "<CMD>wincmd h<CR>")
-- nnoremap("<c-l>", "<CMD>wincmd l<CR>") 
nnoremap("td", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = '[T]oggle [d]iagnostic virtual_lines' })
