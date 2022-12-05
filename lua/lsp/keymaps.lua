require('lspsaga').init_lsp_saga {
  border_style = 'rounded',
  code_action_num_shortcut = true,
  symbol_in_winbar = {
    enable = true,
  },
  code_action_lightbulb = {
    sign = false,
    enable = true,
    cache_code_action = true,
  },
  definition_action_keys = {
    edit = 'o',
  },
  show_outline = {
    win_width = 35,
  },
}

local opts = {
  noremap = true,
  silent = true,
}

-- Lsp finder
vim.keymap.set('n', '<leader>gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
-- Code action
vim.keymap.set({'n','v'}, '<leader>ga', '<cmd>Lspsaga code_action<CR>', opts)
-- Rename
vim.keymap.set('n', '<leader>gr', '<cmd>Lspsaga rename<CR>', opts)
-- Peek definition
vim.keymap.set('n', '<leader>gd', '<cmd>Lspsaga peek_definition<CR>', opts)
-- Diagnsotic window
vim.keymap.set('n', '<leader>cd', '<cmd>Lspsaga show_cursor_diagnostics<CR>', opts)
-- Diagnsotic jump
vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
-- Outline
vim.keymap.set('n', '<leader>o', '<cmd>LSoutlineToggle<CR>', opts)
-- Hover doc
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
