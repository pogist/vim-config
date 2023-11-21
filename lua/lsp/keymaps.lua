require('lspsaga').setup {
  definition = {
    edit = '<CR>',
    quit = '<ESC>',
    vsplit = 's',
  },
  lightbulb = {
    enable = false,
  },
}

local opts = {
  noremap = true,
  silent = true,
}

-- Lsp finder
vim.keymap.set('n', '<leader>gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
-- Code action
vim.keymap.set({ 'n', 'v' }, '<leader>ga', '<cmd>Lspsaga code_action<CR>', opts)
-- Rename
vim.keymap.set('n', '<leader>gr', '<cmd>Lspsaga rename<CR>', opts)
-- Goto definition
vim.keymap.set('n', '<leader>gd', '<cmd>Lspsaga goto_definition<CR>', opts)
-- Diagnsotic window
vim.keymap.set('n', '<leader>cd', '<cmd>Lspsaga show_line_diagnostics<CR>', opts)
-- Diagnsotic jump
vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
-- Outline
vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', opts)
-- Hover doc
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
