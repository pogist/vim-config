require('nvim-web-devicons').setup {
  default = true,
  color_icons = true,
}

local colors = require('tokyonight.colors').setup()
require('lualine').setup {
  options = {
    theme = 'tokyonight',
    globalstatus = true,
    refresh = {
      statusline = 250,
      tabline = 250,
      winbar = 250,
    },
  },
  sections = {
    lualine_a = {
      { 'mode' },
    },
    lualine_b = {
      { 'branch' },
    },
    lualine_c = {
      {
        'diagnostics',
        separator = { right = '' },
        color = { bg = colors.bg_dark },
        always_visible = true,
        sources = { 'nvim_lsp' },
        sections = { 'hint', 'info', 'error', 'warn' },
        update_in_insert = true,
      },
      {
        'filename',
        path = 3,
        file_status = true,
      },
    },
    lualine_x = {
      { 'filetype' },
      {
        'diff',
        separator = { left = '' },
        diff_color = {
          added = 'DiffAdd',
          modified = 'DiffChange',
          removed = 'DiffDelete',
        },
      },
    },
  },
}
