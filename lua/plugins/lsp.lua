return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPost" },
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
    },
    opts = {
      progress = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("lsp").setup(opts)
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = true,
          includeCompletionsForModuleExports = true,
          quotePreference = "single",
        },
      },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
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
