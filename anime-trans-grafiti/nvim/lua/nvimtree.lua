local function tree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "<leader>tr", api.tree.reload)
end

require("nvim-tree").setup({
	on_attach = tree_on_attach,
	reload_on_bufenter = true,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	renderer = {
		group_empty = true,
		highlight_opened_files = "all",
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = false,
    severity = {
      min = vim.diagnostic.severity.ERROR
    } 
	},
})

local tree_api = require("nvim-tree.api")

vim.keymap.set("n", "<C-t>", function()
	tree_api.tree.toggle({ find_file = true })
end)
vim.keymap.set("n", "<leader>tt", function()
	tree_api.tree.toggle({ find_file = true })
end)

-- That's too much magic for me - Auto-Close implementation;
-- source: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close#ppwwyyxx
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		local invalid_win = {}
		local wins = vim.api.nvim_list_wins()
		for _, w in ipairs(wins) do
			local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
			if bufname:match("NvimTree_") ~= nil then
				table.insert(invalid_win, w)
			end
		end
		if #invalid_win == #wins - 1 then
			-- Should quit, so we close all invalid windows.
			for _, w in ipairs(invalid_win) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})
