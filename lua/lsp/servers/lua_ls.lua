return {
  config = function(done)
    require("neodev").setup()
    done({
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
