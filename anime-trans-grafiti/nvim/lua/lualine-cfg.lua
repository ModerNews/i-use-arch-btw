local lualine = require("lualine")

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#1a2a53',
  fg       = '#fefefe',
  alt_bg1  = '#ad2a30',
  yellow   = '#EC8509',
  cyan     = '#4fc7cd',
  darkblue = '#4c6a84',
  green    = '#14423f',
  orange   = '#f36630',
  violet   = '#c678dd',
  magenta  = '#f189c8',
  blue     = '#a1e7eb',
  red      = '#d83e4a',
}

-- local lualine_theme = require("lualine.themes.auto")
local lualine_theme = {}
lualine_theme.normal = {
	a = {
		fg = colors.fg,
		bg = colors.bg,
	},
	b = {
		fg = colors.fg,
		bg = colors.alt_bg1,
	},
	c = {
		fg = colors.fg,
		bg = colors.bg,
	},
}

lualine_theme.inactive = {
	a = {
		fg = colors.fg,
		bg = colors.bg,
	},
	b = {
		fg = colors.fg,
		bg = colors.alt_bg1,
	},
	c = {
		fg = colors.fg,
		bg = colors.alt_bg2,
	},
}

lualine_theme.normal.x = lualine_theme.normal.c
lualine_theme.normal.y = lualine_theme.normal.b
lualine_theme.normal.z = lualine_theme.normal.a

lualine_theme.inactive.x = lualine_theme.inactive.c
lualine_theme.inactive.y = lualine_theme.inactive.b
lualine_theme.inactive.z = lualine_theme.inactive.a

-- Config
local config = {
	options = {
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
		-- section_separators = { left = " ", right = " " },
		theme = lualine_theme,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{
				function()
					return ""
				end,
				color = {
					fg = lualine_theme.normal.b.bg,
					bg = lualine_theme.normal.a.bg,
				},
				padding = { left = 0, right = 0 },
			},
			{
				"filesize",
				-- cond = conditions.buffer_not_empty()
			},
			"filename",
			{
				function()
					return ""
				end,
				color = {
					fg = lualine_theme.normal.b.bg,
					bg = lualine_theme.normal.c.bg,
				},
				padding = { left = 0, right = 0 },
			},
		},
		lualine_c = { "location", "progress" },
		lualine_x = {
			"diff",
		},
		lualine_y = {
			{
				function()
					return ""
				end,
				color = {
					fg = lualine_theme.normal.y.bg,
					bg = lualine_theme.normal.x.bg,
				},
				padding = { left = 0, right = 0 },
			},
			"encoding",
			"fileformat",
		},
		lualine_z = {
			{
				function()
					return ""
				end,
				color = {
					fg = lualine_theme.normal.y.bg,
					bg = lualine_theme.normal.z.bg,
				},
				padding = { left = 0, right = 0 },
			},
		},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
}

lualine.setup(config)
