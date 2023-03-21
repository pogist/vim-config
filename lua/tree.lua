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
  group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
  callback = function()
    local layout = vim.api.nvim_call_function('winlayout', {})
    if layout[1] == 'leaf' then
      local buf = vim.api.nvim_win_get_buf(layout[2])
      local buf_filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
      if buf_filetype:match 'NvimTree' ~= nil and layout[3] == nil then
        vim.cmd 'confirm quit'
      end
    end
  end,
})

vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>')
