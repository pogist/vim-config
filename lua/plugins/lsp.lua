return {
  { "folke/neodev.nvim", lazy = true },
  {
    "neovim/nvim-lspconfig",
    event = { "BufNewFile", "BufReadPost" },
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
    dependencies = { "neovim/nvim-lspconfig" },
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
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
      -- Definitions
      { "<leader>dd", "<cmd>Lspsaga peek_definition<cr>" },
      { "<leader>dt", "<cmd>Lspsaga peek_type_definition<cr>" },
      { "<leader>gd", "<cmd>Lspsaga goto_definition<cr>" },
      { "<leader>gt", "<cmd>Lspsaga goto_type_definition<cr>" },
      -- Diagnostics
      { "<leader>wd", "<cmd>Lspsaga show_workspace_diagnostics ++normal<cr>" },
      { "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<cr>" },
      { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>" },
      { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>" },
    },
    opts = {
      definition = {
        keys = {
          vsplit = "s",
          edit = { "o", "<CR>" },
          quit = { "q", "<ESC>" },
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
