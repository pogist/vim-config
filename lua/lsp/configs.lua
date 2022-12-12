require('mason').setup()
require('mason-lspconfig').setup()

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
}

-- CSS
lspconfig.cssls.setup {
  capabilities = capabilities,
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
}

-- CMake
lspconfig.cmake.setup {
  capabilities = capabilities,
}

-- Dockerfile
lspconfig.dockerls.setup {
  capabilities = capabilities,
}

-- C/C++/Obj-C
lspconfig.ccls.setup {
  capabilities = capabilities,
  init_options = {
    compilationDatabaseDirectory = 'build',
  },
}

-- Graphql
lspconfig.graphql.setup {
  capabilities = capabilities,
}

-- Html
lspconfig.html.setup {
  capabilities = capabilities,
}

-- JSON
lspconfig.jsonls.setup {
  capabilities = capabilities,
}

-- Ruby
lspconfig.solargraph.setup {
  capabilities = capabilities,
}

-- Swift
lspconfig.sourcekit.setup {
  capabilities = capabilities,
  filetypes = { 'swift' },
}

-- JavaScript/TypeScript
lspconfig.tsserver.setup {
  capabilities = capabilities,
}

-- YAML
lspconfig.yamlls.setup {
  capabilities = capabilities,
}

-- Vim
lspconfig.vimls.setup {
  capabilities = capabilities,
}
