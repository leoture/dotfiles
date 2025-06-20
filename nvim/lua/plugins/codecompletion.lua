return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets"
        },
        config = function()
            -- vim.opt.completeopt = { "menu", "menuone", "noselect" }
            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_vscode").lazy_load()
            -- `/` cmdline setup.
            cmp.setup.cmdline("/", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                        {
                            name = "cmdline", 
                            keyword_length = 2,
                            option = {
                                ignore_cmds = { "Man", "!" },
                            },
                        },
                    }),
            })
            cmp.setup({
                -- Where to get completion results from
                sources = cmp.config.sources({
                    { name = 'nvim_lsp', keyword_length = 3, max_item_count = 10 },
                    { name = 'luasnip' },
                    { name = 'buffer', keyword_length = 3, max_item_count = 10 },
                    { name = 'path'}
                }),
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-y>'] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true
                        },
                        { "i", "c" }
                    ),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                },
                snippets = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
    {'saadparwaiz1/cmp_luasnip'},
    {'github/copilot.vim'},
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip"
        },
        lazy = false,
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        config = function(opts)
            local ls = require("luasnip")
            ls.setup(opts)
            local wk = require("which-key")
            wk.add({
                { "<C-k>",
                    function()
                        if ls.expand_or_jumpable() then
                            ls.expand_or_jump()
                        end
                    end,
                    desc = "Expand or jump to next snippet position",
                    mode = { "i", "s" }
                },
                { "<C-j>",
                    function()
                        if ls.jumpable(-1) then
                            ls.jump(-1)
                        end
                    end,
                    desc = "Jump to previous snippet position",
                    mode = { "i", "s" }

                },
            })
        end,
    }
}
