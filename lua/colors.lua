vim.opt.termguicolors = true
require('colorizer').setup {
  css = { css = true },
}

local colors = require('tokyonight.colors').setup()
local util = require 'tokyonight.util'
require('tokyonight').setup {
  lualine_bold = true,
  style = 'night',
  styles = {
    comments = {
      italic = true,
    },
  },
  on_highlights = function(hl, _)
    hl.GitSignsAdd = {
      fg = util.lighten(colors.green, 0.75),
    }
    hl.GitSignsChange = {
      fg = util.lighten(colors.cyan, 0.75),
    }
    hl.GitSignsDelete = {
      fg = util.lighten(colors.magenta2, 0.75),
      bg = colors.black,
    }
    hl.DiffAdd = {
      fg = util.lighten(colors.green, 0.75),
      bg = colors.black,
    }
    hl.DiffChange = {
      fg = util.lighten(colors.cyan, 0.75),
      bg = colors.black,
    }
    hl.DiffDelete = {
      fg = util.lighten(colors.magenta2, 0.75),
      bg = colors.black,
    }
    hl.DiagnosticError = {
      fg = util.lighten(colors.magenta2, 0.75),
      bg = colors.black,
    }
    hl.DiagnosticWarn = {
      fg = util.lighten(colors.yellow, 0.75),
      bg = colors.black,
    }
    hl.DiagnosticHint = {
      fg = util.lighten(colors.green, 0.75),
      bg = colors.black,
    }
    hl.DiagnosticInfo = {
      fg = util.lighten(colors.cyan, 0.75),
      bg = colors.black,
    }
  end,
}

vim.cmd 'colorscheme tokyonight'
