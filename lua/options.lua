vim.opt.termguicolors = true
require('colorizer').setup {
  css = { css = true },
}

require('nvim-web-devicons').setup {
  default = true,
  color_icons = true,
}

local colors = require('tokyonight.colors').setup()
local util = require('tokyonight.util')
require('tokyonight').setup {
  lualine_bold = true,
  style = 'night',
  styles = {
    comments = {
      italic = true,
    },
  },
  on_highlights = function(hl, _)
    hl.DiffAdd = {
      fg = util.lighten(colors.green, 0.7),
      bg = colors.black,
    }
    hl.DiffChange = {
      fg = util.lighten(colors.cyan, 0.7),
      bg = colors.black,
    }
    hl.DiffDelete = {
      fg = util.lighten(colors.magenta2, 0.7),
      bg = colors.black,
    }
    hl.DiagnosticError = {
      fg = util.lighten(colors.magenta2, 0.7),
      bg = colors.black,
    }
    hl.DiagnosticWarn = {
      fg = util.lighten(colors.yellow, 0.7),
      bg = colors.black,
    }
    hl.DiagnosticHint = {
      fg = util.lighten(colors.green, 0.7),
      bg = colors.black,
    }
    hl.DiagnosticInfo = {
      fg = util.lighten(colors.cyan, 0.7),
      bg = colors.black,
    }
  end,
}

vim.cmd 'colorscheme tokyonight'

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
    lualine_a = {{'mode'}},
    lualine_b = {{'branch'}},
    lualine_c = {
      {
        'diagnostics',
        separator = { right = '' },
        color = { bg = colors.bg_dark },
        always_visible = true,
        sources = {'nvim_lsp'},
        sections = {'hint', 'info', 'error', 'warn',},
        update_in_insert = true,
      },
      {
        'filename',
        path = 3,
        file_status = true,
      },
    },
    lualine_x = {
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

vim.opt.mouse = 'a'
vim.opt.inccommand = 'split'
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.hlsearch = false
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

local keymapOpts = {
  noremap = true,
}

vim.keymap.set('n', '<leader>wh', '<C-w>h', keymapOpts)
vim.keymap.set('n', '<leader>wl', '<C-w>l', keymapOpts)

-- Treesitter
local ts_enabled_langs = {
  'css',
  'html',
  'tsx',
  'typescript',
  'javascript',
}

local disable_fn = function(lang, _)
  for _, enabled_lang in ipairs(ts_enabled_langs) do
    if lang == enabled_lang then
      return false
    end
  end
  return true
end

require('nvim-treesitter.configs').setup {
  auto_install = true,
  sync_install = false,
  ensure_installed = ts_enabled_langs,
  highlight = {
    enable = true,
    disable = disable_fn,
  },
  indent = {
    enable = true,
    disable = disable_fn,
  },
  autotag = {
    enable = true,
    disable = disable_fn,
  },
}
