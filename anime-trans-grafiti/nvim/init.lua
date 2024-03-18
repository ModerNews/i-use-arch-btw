local opt = vim.opt
opt.showmode = false
opt.laststatus = 3

opt.clipboard = "unnamedplus"
opt.cursorline = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.softtabstop = 4

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
	"neovim/nvim-lspconfig", -- LSP configurer
	"folke/which-key.nvim", -- keymap
	"folke/neodev.nvim", -- LSP for init.lua nvim file
		"utilyre/barbecue.nvim", -- context map (on top)
	{
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
	},
	"ziontee113/color-picker.nvim", -- color picker (who would have guessed)
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function()
					local gs = require("gitsigns")
				end,
					vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame)
			})
		end,
	},
	"xiyaowong/link-visitor.nvim", -- Url opener (cmd)
	"jghauser/mkdir.nvim", -- create missing directories on write
	"NvChad/nvim-colorizer.lua", -- highlight color definitions with their color
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
	}, -- additional support for highlighting (in depth functions/methods/variables)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = function()
		end,
	},
			require("neotree")
	"creativenull/efmls-configs-nvim", -- Predefined configs for EFM language server
  "lukas-reineke/lsp-format.nvim",   --lsp autoformatting
	"LuaLS/lua-language-server", -- language server for lua
	"adelarsq/image_preview.nvim", -- preview images in terminal
	{
		"NumToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},
		"hrsh7th/nvim-cmp", -- autocompletion
	{
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" }, -- VS Code snippets
			{
				"windwp/nvim-autopairs", -- auto pair parenthesis
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
					require("nvim-autopairs").setup(opts)
				config = function(_, opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

			-- cmp sources plugins
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"onsails/lspkind.nvim", -- VS Code icons for CompletionItemKind
			},
				"nvim-telescope/telescope.nvim", -- file/buffer search
			{
				},
					"nvim-lua/plenary.nvim",
				dependencies = {
			},
			{
				dependencies = {
				"sudormrfbin/cheatsheet.nvim", -- cheatsheet (predefined)
				},
					"nvim-telescope/telescope.nvim",
	},
		},
			},
		end,
			vim.g.copilot_no_tab_map = true
	},
				replace_keycodes = false,
			})
				expr = true,
			vim.keymap.set("i", "<C-Tab>", 'copilot#Accept("\\<CR>")', {
		"github/copilot.vim",
		config = function()
	{
	"nvim-lualine/lualine.nvim", -- Custom status line
	{
		"lukas-reineke/indent-blankline.nvim",
		dependencies = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		main = "ibl",
	}, -- indent lines
		opts = {},
	{
		"folke/noice.nvim", -- custom bubbles
			-- "folke/lsp-colors.nvim", -- LSP colors
		dependencies = {
			-- "folke/lsp-trouble.nvim", -- LSP trouble
			-- "folke/lsp-status.nvim", -- LSP status
			"rcarriga/nvim-notify", -- notifications
			"MunifTanjim/nui.nvim", -- UI components
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			keywords = {
		},
		opts = {
				FIX = { icon = " ", color = "default", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "hint" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "info", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			colors = {
				info = { "DiagnosticInfo", "#2563EB" }, -- TODO: DiagnosticInfo
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" }, -- HACK: WarningMsg
				hint = { "DiagnosticHint", "#10B981" }, -- NOTE: DiagnosticHint
				test = { "Identifier", "#FF00FF" }, -- FIX:
				default = { "Identifier", "#7C3AED" }, -- PERF:
			},
		},
		config = function()
			require("todo-comments").setup({
				on_attach = {
					function() end,
				},
			})
	{
	},
		end,
	},
		opts = {},
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
})

vim.keymap.set("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"css",
		"csv",
		"dockerfile",
		"dot",
		"git_config",
		"javascript",
		"json",
		"html",
		"regex",
		"python",
	},
	ignore_install = { "haskell" },
	sync_install = false,
	auto_install = true,
	highlight = { enable = true },
	autotag = { enable = true },
})

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

local rainbow_delimiters = require("rainbow-delimiters")
vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	priority = {
		[""] = 110,
		lua = 210,
	},
	highlight = highlight,
}

require("ibl").setup({
	indent = {
		highlight = { "Comment" },
		-- level = 1,
	},
	scope = { highlight = { "Identifier" } },
})
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", {})
vim.keymap.set("n", "<C-k>", builtin.buffers, {})

require("lspconfigure") -- load LSP configuration from external lua file
require("image_preview").setup()

local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
require("luasnip.loaders.from_vscode").lazy_load()

opt.completeopt = "menu,menuone,noselect"

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<Tab>"] = cmp.mapping.select_next_item(),   -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  -- sources for autocompletion
  sources = cmp.config.sources({
    -- { name = "efm"}, -- EFM
    { name = "nvim_lsp" }, -- LSP
    { name = "luasnip" },  -- snippets
    { name = "buffer" },   -- text within the current buffer
    { name = "path" },     -- file system paths
  }),
  window = {
    completion = {
      winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenu,NormalThumb:CmpMenuThumb,PmenuSbar:CmpMenuSbar",
      col_offset = -3,
      side_padding = 0,
      border = border("Normal"),
    },
    documentation = {
      winhighlight = "Normal:CmpMenu,FloatBorder:CmpMenu,NormalThumb:CmpMenuThumb,PmenuSbar:CmpMenuSbar",
      border = border("Normal"),
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. (strings[1] or "") .. " "
      kind.menu = "    (" .. (strings[2] or "") .. ")"

      return kind
    end,
  },
})

require("colorizer").setup()

vim.cmd("colorscheme custom")

local colors = {
	text = "#d83e4a",
	inactive_bg = "#1a2a53",
	active_bg1 = "#1b1722",
	active_bg2 = "#f36630",
}

require("lualine-cfg")

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = custom_auto_lualine,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "NvimTree" },
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = { "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = { "filetype" },
    lualine_z = { "progress" },
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})

require("barbecue").setup()
require("barbecue.ui").toggle(true)
require("cheatsheet").setup()

vim.keymap.set("n", "<leader>cc", "<cmd>PickColor<cr>", opts)
vim.keymap.set("i", "<leader>ci", "<cmd>PickColorInsert<cr>", opts)

require("color-picker").setup({
  ["icons"] = { "ﱢ", "" },
  ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
  ["keymap"] = {          -- mapping example:
    ["U"] = "<Plug>ColorPickerSlider5Decrease",
    ["O"] = "<Plug>ColorPickerSlider5Increase",
  },
  ["background_highlight_group"] = "CmpMenu",
  ["border_highlight_group"] = "CmpMenu",
  ["text_highlight_group"] = "CmpMenu",
})

require("link-visitor").setup()
require("lspsaga").setup()

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	cmdline = {
		enabled = true,
		view = "cmdline_popup",
	},
})
