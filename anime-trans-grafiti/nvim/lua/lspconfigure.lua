require("neodev").setup()

local languages = require("efmls-configs.defaults").languages()
languages = vim.tbl_extend("force", languages, {
    -- Custom languages, or override existing ones
    javascript
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            "documentation",
            "detail",
            "additionalTextEdits",
        },
    },
}

local efmls_config = {
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = { ".git/" },
        languages = languages,
    },
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
    capabilities = capabilities,
}

local lspconfig = require("lspconfig")
lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {}))
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
lspconfig.dockerls.setup({ capabilities = capabilities })
lspconfig.cssmodules_ls.setup({ capabilities = capabilities })
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.marksman.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.vimls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })

require("lsp-format").setup()
local on_attach = function(client, bufnr)
    require("lsp-format").on_attach(client, bufnr)
end

local lspconfig = require("lspconfig")
lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {}), { on_attach = on_attach })
lspconfig.lua_ls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.pyright.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.docker_compose_language_service.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.dockerls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.cssmodules_ls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.html.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.marksman.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.rust_analyzer.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.vimls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.tsserver.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.awk_ls.setup({ capabilities = capabilities, on_attach = on_attach })

lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})
