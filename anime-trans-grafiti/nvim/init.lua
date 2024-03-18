local opt = vim.opt
opt.showmode = true

opt.clipboard = "unnamedplus"
opt.cursorline = false

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 2
opt.softtabstop = 2

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
  "neovim/nvim-lspconfig",   -- LSP configurer
  "folke/which-key.nvim",    -- keymap
  "folke/neodev.nvim",       -- LSP for init.lua nvim file
  {
    "utilyre/barbecue.nvim", -- context map (on top)
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  },
  "ziontee113/color-picker.nvim",    -- color picker (who would have guessed)
  "lewis6991/gitsigns.nvim",         -- TODO: gitsigns
  "xiyaowong/link-visitor.nvim",     -- Url opener (cmd)
  "jghauser/mkdir.nvim",             -- create missing directories on write
  "NvChad/nvim-colorizer.lua",       -- highlight color definitions with their color
  "nvim-treesitter/nvim-treesitter", -- additional support for highlighting (in depth functions/methods/variables)
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  {
    "nvim-tree/nvim-tree.lua", -- directory tree
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  "creativenull/efmls-configs-nvim", -- Predefined configs for EFM language server
  "lukas-reineke/lsp-format.nvim",   -- LSP-based autoformatting
  "adelarsq/image_preview.nvim",     -- preview images in terminal
  "LuaLS/lua-language-server",       -- language server for lua
  "nvimdev/lspsaga.nvim",            -- lsp helper
  "lukas-reineke/lsp-format.nvim",   --lsp autoformatting
  {
    "hrsh7th/nvim-cmp",              -- autocompletion
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" }, -- VS Code snippets
      {
        "windwp/nvim-autopairs",                                             -- auto pair parenthesis
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

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
        "onsails/lspkind.nvim",          -- VS Code icons for CompletionItemKind
      },
      "nvim-lualine/lualine.nvim",       -- Custom status line
      {
        "nvim-telescope/telescope.nvim", -- file/buffer search
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
      },
      {
        "sudormrfbin/cheatsheet.nvim", -- cheatsheet (predefined)
        dependencies = {
          "nvim-telescope/telescope.nvim",
        },
      },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "github/copilot.vim"
  }
})

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
  sync_install = false,
  auto_install = true,
  highlight = { enable = true },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
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


require("nvimtree")

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
