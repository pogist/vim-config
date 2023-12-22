return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
