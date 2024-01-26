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
        ccls = {
          init_options = {
            compilationDatabaseDirectory = "build",
            clang = {
              extraArgs = {
                "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/c++/v1",
                "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/clang/15.0.0/include",
                "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include",
                "-isystem/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include",
                "-isystem/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks",
              },
            },
          },
          -- root_dir = require("lspconfig.util").root_pattern(
          --   ".git",
          --   ".ccls",
          --   "compile_flags.txt",
          --   "compile_commands.json",
          --   "build/compile_flags.txt",
          --   "build/compile_commands.json"
          -- ),
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
