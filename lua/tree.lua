vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require 'nvim-tree.api'

local function on_attach(bufnr)
  -- Apply default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- Override defaults
  local opts = function(desc)
    return {
      buffer = bufnr,
      desc = 'nvimtree: ' .. desc,
      noremap = true,
      nowait = true,
      silent = true,
    }
  end

  vim.keymap.set('n', 'Z', api.node.run.system, opts 'Run System')
  vim.keymap.set('n', 's', api.node.open.vertical, opts 'Open: Vertical Split')
end

require('nvim-tree').setup {
  on_attach = on_attach,
  diagnostics = { enable = true },
  git = { ignore = false },
  view = {
    adaptive_size = true,
    relativenumber = true,
    centralize_selection = true,
  },
  renderer = {
    add_trailing = true,
  },
}

-- Register custom toggle command before tree is attached
vim.keymap.set('n', '<C-n>', function()
  api.tree.toggle()
end)

-- Auto close nvim-tree when quitting the editor
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
