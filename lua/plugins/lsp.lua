return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPost" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
    },
    opts = {
      -- LSP servers configuration
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("../util/lsp").config(opts)
    end,
  },
}
