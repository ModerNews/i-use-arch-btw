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

local lualine_theme = require("lualine.themes.auto")
lualine_theme.normal.c.fg = colors.text
lualine_theme.insert.c.fg = colors.text
lualine_theme.replace.c.fg = colors.text
lualine_theme.visual.c.fg = colors.text
lualine_theme.command.c.fg = colors.text
lualine_theme.inactive = {
  a = { fg = colors.text, bg = colors.inactive_bg, gui = "bold" },
  b = { fg = colors.inactive_bg, bg = colors.text },
  c = { fg = colors.text, bg = colors.inactive_bg },
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
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = lualine_theme,
    disabled_filetypes = {
      statusline = { "NvimTree" },
      winbar = {},
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
