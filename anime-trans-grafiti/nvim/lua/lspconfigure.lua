require("neodev").setup()

local languages = require("efmls-configs.defaults").languages()
languages = vim.tbl_extend("force", languages, {
	-- Custom languages, or override existing ones
	html = {
		require("efmls-configs.formatters.prettier"),
	},
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
lspconfig.marksman.setup({ capabilities = capabilities})
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.vimls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })

local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = lsp_fmt_group,
	callback = function(ev)
		local efm = vim.lsp.get_active_clients({ name = "efm", bufnr = ev.buf })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm" })
	end,
})
