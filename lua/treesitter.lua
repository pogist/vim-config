require('nvim-treesitter.install').compilers = {
  'clang',
}

require('nvim-treesitter.configs').setup {
  modules = {},
  ignore_install = {},
  ensure_installed = {},
  auto_install = true,
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
  autotag = {
    enable = true,
    enable_close_on_slash = false,
  },
}

vim.treesitter.language.register('tsx', {
  'javascript',
  'javascript.jsx',
  'javascriptreact',
  'typescript',
  'typescript.tsx',
  'typescriptreact',
})

vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup {
  enable_autocmd = false,
}
require('Comment').setup {
  toggler = {
    line = '<leader>cc',
    block = '<leader>bc',
  },
  opleader = {
    line = '<leader>c',
    block = '<leader>b',
  },
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
