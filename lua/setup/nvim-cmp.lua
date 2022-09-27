local cmp = require('cmp')
local icons = _G.icons

cmp.setup({
    debug = false,
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,

    window = {
        documentation = true,
    },

    completion = {
        keyword_length = 1,
    },

    snippet = {
      -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },

    mapping = {
        ['<C-j>'] = cmp.mapping.select_next_item(
            { behavior = cmp.SelectBehavior.Select }),
        ['<C-k>'] = cmp.mapping.select_prev_item(
            { behavior = cmp.SelectBehavior.Select }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },

    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer',
            options = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = 'path' },
        { name = 'vsnip'}, -- For `vsnip` users
    },

    formatting = {
        fields = { 'kind', 'abbr', 'menu'},
        format = function(entry, item)
            local kind_name = item.kind
            item.kind = icons[item.kind] or ''
            item.menu = ({
                nvim_lsp = '[L]',
                buffer = '[B]',
                path = '[P]',
            })[entry.source.name]..' '..kind_name
            return item
        end,
    },

    experimental = {
        ghost_text = {
            hl_group = 'Whitespace'
        },
    },
})
