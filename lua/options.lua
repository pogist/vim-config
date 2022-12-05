require('nvim-web-devicons').setup {
  default = true,
  color_icons = true,
}

require('lualine').setup {
  options = {
    theme = 'material',
  },
}

require('material').setup {
  styles = {
    comments = { italic = true }
  },
  lualine_style = 'default',
}

vim.g.material_style = 'deep ocean'
vim.cmd 'colorscheme material'

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
