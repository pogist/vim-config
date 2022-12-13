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
null_ls.setup {
  on_attach = on_attach,
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.diagnostics.eslint_d,
  },
}
