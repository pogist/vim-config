require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = vim.api.nvim_create_augroup('Format', { clear = true }),
      callback = function()
        vim.lsp.buf.formatting_seq_sync()
      end,
    })
  end
end

-- Lua
lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach,
}

-- CSS
lspconfig.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- CSS modules
lspconfig.cssmodules_ls.setup {
  capabilities = capabilities,
  filetypes = {
    'javascript.jsx',
    'javascriptreact',
    'typescript.tsx',
    'typescriptreact',
  },
  on_attach = on_attach,
}

-- CMake
lspconfig.cmake.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Dockerfile
lspconfig.dockerls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- C/C++/Obj-C
lspconfig.ccls.setup {
  capabilities = capabilities,
  init_options = {
    compilationDatabaseDirectory = 'build',
  },
  on_attach = on_attach,
}

-- Graphql
lspconfig.graphql.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Html
lspconfig.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- JSON
lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Ruby
lspconfig.solargraph.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Swift
lspconfig.sourcekit.setup {
  capabilities = capabilities,
  filetypes = { 'swift' },
  on_attach = on_attach,
}

-- JavaScript/TypeScript
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- YAML
lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Vim
lspconfig.vimls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
