vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

require('nvim-tree').setup {
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  git = {
    ignore = false,
  },
  view = {
    adaptive_size = true,
    centralize_selection = true,
    hide_root_folder = true,
    relativenumber = true,
  },
  renderer = {
    add_trailing = true,
    highlight_opened_files = 'icon',
  },
}

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    local winnr = vim.api.nvim_eval("winnr('$')")
    local tabpagenr = vim.api.nvim_eval('tabpagenr()')
    local bufname = vim.api.nvim_eval('bufname()')
    if winnr == 1 and bufname == 'NvimTree_' .. tabpagenr then
      vim.api.nvim_exec('quit', false)
    end
  end
})

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
