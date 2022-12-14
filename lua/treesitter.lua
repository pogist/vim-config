local ts_enabled_langs = {
  'tsx',
  'css',
  'html',
  'jsdoc',
  'javascript',
  'typescript',
}

local disable_fn = function(lang, _)
  for _, enabled_lang in ipairs(ts_enabled_langs) do
    if lang == enabled_lang then
      return false
    end
  end
  return true
end

require('nvim-treesitter.configs').setup {
  auto_install = true,
  sync_install = false,
  ensure_installed = ts_enabled_langs,
  highlight = {
    enable = true,
    disable = disable_fn,
  },
  indent = { enable = true },
  autotag = { enable = true },
  context_commentstring = {
    enable = true,
    commentary_integration = {
      Commentary = '<leader>c',
      CommentaryLine = '<leader>cc',
      CommentaryUndo = '<leader>cu',
    },
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.tsx.filetype_to_parsername = {
  'javascript',
  'typescript',
  'typescript.tsx',
}
