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
vim.keymap.set({ 'o', 'x' }, '<leader>r', '<Plug>(Luadev-Run)')
vim.keymap.set('n', '<leader>rl', '<Plug>(Luadev-RunLine)')
