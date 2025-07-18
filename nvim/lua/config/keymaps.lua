local wk = require("which-key")
wk.add({
  {"<M-J>" , "<cmd>m '>+1<cr>gv=gv", desc = "Move line down", mode = "v"},
  {"<M-K>", "<cmd>m '<-2<cr>gv=gv", desc = "Move line up", mode = "v"},
  {"n", "nzzzv", desc = "Next search result centered"},
  {"N", "Nzzzv", desc = "Previous search result centered"},

 { "<leader>d", group = "Debug", icon = ""},
        { "<leader>db", require("dap").toggle_breakpoint, desc = "Toggle Breakpoint" },
        { "<leader>dr", require("dap").continue, desc = "Run/Continue", icon = "" },
        { "<leader>dp", require("dap").pause, desc = "Pause", icon = "" },
        { "<leader>dR", require("dap").run_last, desc = "Run Last", icon = "" },
        { "<leader>di", require("dap").step_into, desc = "Step Into", icon = "󰆹" },
        { "<leader>do", require("dap").step_over, desc = "Step Over", icon = "󰆷" },
        { "<leader>dO", require("dap").step_out, desc = "Step Out", icon = "󰆸" },
        { "<leader>dD", require("dap").disconnect, desc = "Disconnect", icon = ""},
        { "<leader>du", require("dapui").toggle, desc = "Toggle DAP UI" },

  {"<leader>p", [["_dP]], desc = "Paste without overwriting register", mode = "x" },
  {"<leader>Y", [["+Y]], desc = "Yank line to system clipboard", mode = { "n", "v" } },
  {"<leader>y", [["+y]], desc = "Yank to system clipboard", mode = { "n" , "v" } },

  { "<leader>r", group = "[R]un", icon = "" },
  { "<leader>rts", "<cmd>TestSuite<cr>", desc = "[R]un [T]est [S]uite" },
  { "<leader>rtn", "<cmd>TestNearest<cr>", desc = "[R]un [T]est [N]earest" },
  { "<leader>rtf", "<cmd>TestFile<cr>", desc = "[R]un [T]est [F]ile" },
  { "<leader>rtl", "<cmd>TestLast<cr>", desc = "[R]un [T]est [L]ast" },
  { "<leader>rtv", "<cmd>TestVisit<cr>", desc = "[R]un [T]est [V]isit" },

  { "<leader>t", group = "[T]oggle", icon = "󰨙 " },
  { "<leader>td", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "[T]oggle [D]iagnostics (Current Buf)" },
  { "<leader>tid",
    function()
      local new_config = not vim.diagnostic.config().virtual_text
      vim.diagnostic.config({ virtual_text = new_config })
    end,
    desc = "[T]oggle [I]nline [D]iagnostics" },
  { "<leader>tD", "<cmd>Trouble diagnostics toggle<cr>", desc = "[T]oggle [D]iagnostics (All)" },
  { "<leader>ts", "<cmd>Trouble symbols toggle focus=true win.size=50<cr>", desc = "[T]oggle [S]ymbols" },
  { "<leader>tl", "<cmd>Trouble lsp toggle focus=true win.relative=win win.position=bottom win.size=30<cr>", desc = "[T]oggle [L]SP Definitions/References/..." },
  { "<leader>tt", "<cmd>TodoQuickFix<cr>", desc = "[T]oggle [T]odo QuickFix" },
  { "<leader>tgb", function() require("gitsigns").toggle_current_line_blame() end, desc = "[T]oggle [g]it show [b]lame line" },

  { "<leader>f", group = "[F]ind", icon = " " },
  { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[F]ind [T]odo" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[F]ind [H]elp" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[F]ind [F]iles" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[F]ind [G]rep" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind [B]uffers" },
  { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "[F]ind [C]ommands" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "[F]ind [K]eymaps" },
  { "<leader>fs", "<cmd>Telescope builtin<cr>", desc = "[F]ind [S]earch" },
  { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "[F]ind [R]esume" },

  { "<leader>fl", group = "[F]ind [L]SP", icon = "󰒻 " },
  { "<leader>fld", "<cmd>Telescope lsp_definitions<cr>", desc = "[F]ind [D]efinitions" },
  { "<leader>fli", "<cmd>Telescope lsp_implementations<cr>", desc = "[F]ind [I]mplementations" },
  { "<leader>flr", "<cmd>Telescope lsp_references<cr>", desc = "[F]ind [R]eferences" },


  { "<leader>]", group = "Next", icon = " " },
  { "<leader>]c",
  function() 
    if vim.wo.diff then
      vim.cmd.normal { "]c", bang = true }
    else
      require("gitsigns").nav_hunk "next"
    end
  end, desc = "Next Git Change" },
  { "<leader>]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
  { "<leader>]d", function() vim.diagnostic.jump { count = 1 } end, desc = "Next Diagnostic" },
  { "<leader>]i",
    function()
      local ls = require("luasnip")
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end,
    desc = "Expand or jump to next snippet position",
    mode = { "i", "s" }
  },

  { "<leader>[", group = "Previous", icon = " " },
  { "<leader>[c",
  function() 
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      require("gitsigns").nav_hunk "prev"
    end
  end, desc = "Previous Git Change" },
  { "<leader>[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
  { "<leader>[d", function() vim.diagnostic.jump { count = -1 } end, desc = "Previous Diagnostic" },
  { "<leader>[i",
    function()
      local ls = require("luasnip")
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end,
    desc = "Jump to previous snippet position",
    mode = { "i", "s" }

  },
  { "<leader><tab>", vim.lsp.buf.format, desc = "Format Document" },
  { "<leader><cr>", vim.lsp.buf.code_action, desc = "Code Action" },

  { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon buffer [1]" },
  { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon buffer [2]" },
  { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon buffer [3]" },
  { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon buffer [4]" },

  { "<leader>mn", function() require("harpoon"):list():next() end, desc = "Harpoon [M]ark [N]ext" },
  { "<leader>mp", function() require("harpoon"):list():prev() end, desc = "Harpoon [M]ark [P]revious" },

  { "<leader>hm", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "[H]arpoon Toggle [M]enu" },
  { "<leader>ma", function() require("harpoon"):list():add() end, desc = "Harpoon [M]ark [A]dd file" },
  { "<leader>mc", function() require("harpoon"):list():clear() end, desc = "Harpoon [M]ark [C]lear" },
  { "<leader>md", function() require("harpoon"):list():remove() end, desc = "Harpoon [M]ark [D]elete" },

  { "<leader>gs", function() require("gitsigns").stage_hunk() end, desc = "[G]it [S]tage hunk" },
  { "<leader>gs", function() require("gitsigns").stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = "[G]it [S]tage hunk", mode = "v" },
  { "<leader>gr", function() require("gitsigns").reset_hunk() end, desc = "[G]it [R]eset hunk" },
  { "<leader>gr", function() require("gitsigns").reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, desc = "[G]it [R]eset hunk", mode = "v" },
  { "<leader>gS", function() require("gitsigns").stage_buffer() end, desc = "Git [S]tage buffer" },
  { "<leader>gR", function() require("gitsigns").reset_buffer() end, desc = "Git [R]eset buffer" },
  { "<leader>gp", function() require("gitsigns").preview_hunk() end, desc = "Git [P]review hunk" },
  { "<leader>gb", function() require("gitsigns").blame_line() end, desc = "Git [B]lame line" },
  { "<leader>gd", function() require("gitsigns").diffthis() end, desc = "Git [D]iff against index" },
  { "<leader>gD", function() require("gitsigns").diffthis '@' end, desc = "Git [D]iff against last commit" },

})

