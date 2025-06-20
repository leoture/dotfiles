return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUinstall", "LspStart", "LspStop", "LspRestart" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities({
        textDocument = {
          diagnostic = {
            dynamicRegistration = true,
            relatedDocumentSupport = true
          }
        },
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        }
      })
      local lspconfig = require('lspconfig')
      lspconfig.sourcekit.setup {
        root_dir = lspconfig.util.root_pattern(".git", "Package.swift", "compile_commands.json"),
        capabilities = capabilities
      }

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP Actions',
        callback = function(args)
          local telescope = require('telescope.builtin')
          vim.keymap.set("n", "K",        vim.lsp.buf.hover,              { desc = "LSP: hover info" })
          vim.keymap.set("n", "gd",       telescope.lsp_definitions,      { desc = "LSP: [G]oto [D]efinition" })
          vim.keymap.set("n", "gD",       vim.lsp.buf.declaration,        { desc = "LSP: [G]oto [D]eclaration" })
          vim.keymap.set("n", "gi",       telescope.lsp_implementations,  { desc = "LSP: [G]oto [I]mplementation"})
          vim.keymap.set("n", "gr",       telescope.lsp_references,       { desc = "LSP: [G]oto [R]eferences"})
          vim.keymap.set("n", "gn",       vim.lsp.buf.rename,             { desc = "LSP: LSP rename"})
          vim.keymap.set("n", "g<Up>",    vim.diagnostic.goto_prev,       { desc = "LSP: Go to previous diagnostic"})
          vim.keymap.set("n", "g<Down>",  vim.diagnostic.goto_next,       { desc = "LSP: Go to next diagnostic"})
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,      { desc = "LSP: Code Action"})
          vim.keymap.set("n", "<leader><tab>", vim.lsp.buf.format)
        end,
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls", "rust_analyzer" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  }
}
