local lib = require 'nvim-tree.lib'

local function vsplit_preview()
  local action = 'vsplit'
  local node = lib.get_node_at_cursor()
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
  end
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
  diagnostics = { enable = true },
  git = { ignore = false },
  view = {
    adaptive_size = true,
    centralize_selection = true,
    hide_root_folder = true,
    relativenumber = true,
    mappings = {
      custom_only = false,
      list = {
        { key = 's', action = 'vsplit_preview', action_cb = vsplit_preview },
      },
    },
  },
  renderer = {
    add_trailing = true,
  },
}

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    local winnr = vim.api.nvim_eval "winnr('$')"
    local tabpagenr = vim.api.nvim_eval 'tabpagenr()'
    local bufname = vim.api.nvim_eval 'bufname()'
    if winnr == 1 and bufname == 'NvimTree_' .. tabpagenr then
      vim.api.nvim_exec('quit', false)
    end
  end,
})

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
