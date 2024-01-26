return {
  ccls = {
    auto_format = true,
    config = function(done)
      done({
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
        root_dir = require("lspconfig.util").root_pattern(
          ".git",
          ".ccls",
          "compile_flags.txt",
          "compile_commands.json",
          "build/compile_flags.txt",
          "build/compile_commands.json"
        ),
      })
    end,
  },
  lua_ls = {
    auto_format = true,
    config = {
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
}
