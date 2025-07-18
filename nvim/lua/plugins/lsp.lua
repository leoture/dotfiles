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
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "lua_ls", "rust_analyzer", "marksman" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  }
}
