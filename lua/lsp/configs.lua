local lspconfig = require 'lspconfig'
local util = require 'lspconfig.util'
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('neodev').setup {}

-- Lua
lspconfig.lua_ls.setup {
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

-- CMake
require('lspconfig').neocmake.setup {
  capabilities = capabilities,
}

-- Dockerfile
lspconfig.dockerls.setup {
  capabilities = capabilities,
}

-- C/C++
lspconfig.ccls.setup {
  capabilities = capabilities,
  init_options = {
    compilationDatabaseDirectory = 'build',
  },
  root_dir = util.root_pattern(
    '.git',
    '.ccls',
    'compile_flags.txt',
    'compile_commands.json',
    'build/compile_flags.txt',
    'build/compile_commands.json'
  ),
}

-- HTML
lspconfig.html.setup {
  capabilities = capabilities,
}

-- JSON
lspconfig.jsonls.setup {
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
  commands = {
    -- Organize imports command
    SortImports = {
      description = 'Sort typescript imports',
      function()
        vim.lsp.buf.execute_command {
          title = '[tsserver] organizeImports',
          command = '_typescript.organizeImports',
          arguments = { vim.api.nvim_buf_get_name(0) },
        }
      end,
    },
  },
}

-- YAML
lspconfig.yamlls.setup {
  capabilities = capabilities,
}

-- Vim
lspconfig.vimls.setup {
  capabilities = capabilities,
}

-- Bash
lspconfig.bashls.setup {
  capabilities = capabilities,
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('UserLspFormatting', {}),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            -- JavaScript/TypeScript formatting is usually handled by eslint/prettier.
            -- So I prefer disabling tsserver to avoid inconsistencies.
            filter = function(c)
              return c.name ~= 'tsserver'
            end,
          }
        end,
      })
    end
  end,
})
