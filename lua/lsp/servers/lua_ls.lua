return {
  config = function(done)
    require("neodev.config").setup()
    done({
      before_init = require("neodev.lsp").before_init,
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
    })
  end,
}
