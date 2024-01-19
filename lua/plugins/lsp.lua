return {
  {
    "neovim/nvim-lspconfig",
    version = false,
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
      require("util.lsp").config(opts)
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    version = false,
    event = "LspAttach",
    keys = {
      -- Hover
      { "K", "<cmd>Lspsaga hover_doc<cr>" },
      -- Diagnostics
      { "<leader>wd", "<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>" },
      { "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<cr>" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>" },
    },
    opts = {
      definition = {
        keys = {
          edit = "<CR>",
          quit = "<ESC>",
          vsplit = "s",
        },
      },
      diagnostic = {
        extend_relatedInformation = true,
        keys = {
          quit = { "q", "<ESC>" },
        },
      },
      lightbulb = {
        enable = false,
      },
      scroll_preview = {
        scroll_up = "<C-k>",
        scroll_down = "<C-j>",
      },
    },
  },
}
