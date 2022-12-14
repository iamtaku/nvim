-- workaround for certain languages and uses snippet plugin(vimsnippet?)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = {
    -- Rust
    { 'rust_analyzer' },

    -- Python
    { 'pylsp' },
    { 'jedi_language_server' },
    { 'pyright' },

    -- Lua
    { 'sumneko_lua',
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },

    -- C/C++
    { 'clangd',
        cmd = { 'clangd', '--completion-style=detailed' },
    },

    -- Godot
    { 'gdscript' },

    -- Latex
    { 'texlab' },

    -- Haskell
    { 'hls' },

    --Typescript
    { 'tsserver' },

    --Emmet
    { 'emmet_ls'},

    --JSON
    { 'jsonls',
        capabilities = capabilities,
    },

    --CSS modules
    { 'cssmodules_ls'},

    --CSS
    { 'cssls',
        capabilities = capabilities,
    },

    --HTML
    { 'html',
        capabilities = capabilities,
    }
}

-- Only enable the server if it's installed on the system
local lsp = require('lspconfig')
for _, server in pairs(servers) do
    local config = lsp[server[1]]

    if(lsp.util.available_servers(config.document_config.default_config.cmd[1])) then
        local opts = {}
        for k, v in pairs(server) do
            if type(k) ~= 'number' then
                opts[k] = v
            end
        end

        config.setup(opts)
    end
end
