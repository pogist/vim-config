local event = 'BufWritePre'
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local on_attach = function(client, bufnr)
  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd(event, {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          bufnr = bufnr,
          filter = function(c)
            return c.name ~= 'tsserver'
          end,
        }
      end,
    })
  end
end

local null_ls = require 'null-ls'
local null_ls_utils = require 'null-ls.utils'
local node_utils = require 'utils.node'

null_ls.setup {
  on_attach = on_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd.with {
      condition = node_utils.condition {
        root = function()
          return null_ls_utils.get_root()
        end,
        package_json = {
          config_key = 'prettier',
          dependency = 'prettier',
        },
        config_files = {
          '.prettierrc',
          '.prettierrc.json',
          '.prettierrc.yml',
          '.prettierrc.yaml',
          '.prettierrc.json5',
          '.prettierrc.js',
          '.prettierrc.cjs',
          'prettier.config.js',
          'prettier.config.cjs',
          '.prettierrc.toml',
        },
      },
    },
    null_ls.builtins.diagnostics.eslint_d.with {
      condition = node_utils.condition {
        root = function()
          return null_ls_utils.get_root()
        end,
        package_json = {
          config_key = 'eslintConfig',
          dependency = 'eslint',
        },
        config_files = {
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json',
        },
      },
    },
  },
}
