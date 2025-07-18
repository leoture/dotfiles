vim.opt.wildmenu      = true
vim.opt.wildmode      = "list:longest,list:full" -- don't insert, show options
vim.opt.conceallevel  = 1

-- Enable relative line numbers
vim.opt.nu            = true
vim.opt.rnu           = true

-- Set tabs to 2 spaces
vim.opt.tabstop       = 2
vim.opt.softtabstop   = 2
vim.opt.expandtab     = true

-- Enable auto indenting and set it to spaces
vim.opt.smartindent   = true
vim.opt.shiftwidth    = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent   = true

-- Enable incremental searching
vim.opt.incsearch     = true
vim.opt.hlsearch      = true

-- Disable text wrap
vim.opt.wrap          = false

-- Set leader key to space
vim.g.mapleader       = " "
vim.g.maplocalleader  = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true 

-- Better splitting
vim.opt.splitbelow    = true
vim.opt.splitright    = true

-- Enable mouse mode
vim.opt.mouse         = "a"

-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase    = true
vim.opt.smartcase     = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt   = { "menu", "menuone", "noselect" }

-- Enable persistent undo history
vim.opt.undofile      = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn    = "yes"

-- Enable cursor line highlight
vim.opt.cursorline    = true

-- Always keep 8 lines above/below cursor unless at start/end of file
vim.opt.scrolloff     = 8

vim.opt.wrap          = true

vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-CursorInsert,r-cr:hor20-CursorReplace'
vim.cmd([[
  highlight Cursor guifg=bg guibg=fg
  highlight lCursor guifg=bg guibg=fg
  highlight CursorInsert guifg=bg guibg=fg
  highlight CursorReplace guifg=bg guibg=fg
]])

-- Highlight entire line for errors
-- Highlight the line number for warnings
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN]  = '󰀪 ',
      [vim.diagnostic.severity.HINT]  = '󰌶 ',
      [vim.diagnostic.severity.INFO]  = '󰋽 ',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN]  = 'WarningMsg',
      [vim.diagnostic.severity.HINT]  = 'HintMsg',
      [vim.diagnostic.severity.INFO]  = 'InfoMsg',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN]  = 'WarningMsg',
      [vim.diagnostic.severity.HINT]  = 'HintMsg',
      [vim.diagnostic.severity.INFO]  = 'InfoMsg',
    },
  },
})

vim.g.copilot_enabled = 1
