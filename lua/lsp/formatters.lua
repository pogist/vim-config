local null_ls = require 'null-ls'
local null_ls_utils = require 'null-ls.utils'
local node_utils = require 'utils.node'

local augroup = vim.api.nvim_create_augroup('UserLspFormatting', {})
local function on_attach(client, bufnr)
  if client.supports_method 'textDocument/formatting' then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          async = false,
          filter = function(c)
            return c.name ~= 'tsserver'
          end,
        }
      end,
    })
  end
end

null_ls.setup {
  on_attach,
  sources = {
    null_ls.builtins.formatting.shfmt,
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
