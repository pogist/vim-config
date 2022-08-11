call plug#begin()

" Coc.nvim
let install_pkg = { 'do': 'yarn install --frozen-lockfile' }
let install_coc = extend(install_pkg, { 'branch': 'master' })

Plug 'clangd/coc-clangd', install_pkg
Plug 'fannheyward/coc-marketplace', install_pkg
Plug 'fannheyward/coc-pyright', install_pkg
Plug 'fannheyward/coc-rust-analyzer', install_pkg
Plug 'iamcco/coc-diagnostic', install_pkg
Plug 'iamcco/coc-vimlsp', install_pkg
Plug 'josa42/coc-go', install_pkg
Plug 'josa42/coc-sh', install_pkg
Plug 'klaaspieter/coc-sourcekit', install_pkg
Plug 'neoclide/coc-css', install_pkg
Plug 'neoclide/coc-emmet', install_pkg
Plug 'neoclide/coc-eslint', install_pkg
Plug 'neoclide/coc-html', install_pkg
Plug 'neoclide/coc-json', install_pkg
Plug 'neoclide/coc-prettier', install_pkg
Plug 'neoclide/coc-snippets', install_pkg
Plug 'neoclide/coc-solargraph', install_pkg
Plug 'neoclide/coc-tsserver', install_pkg
Plug 'neoclide/coc-yaml', install_pkg
Plug 'neoclide/coc.nvim', install_coc

" Appearance
Plug 'base16-project/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'

" Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tpope/vim-fugitive'

" Language support
Plug 'HerringtonDarkholme/yats.vim'
Plug 'Olical/aniseed'
Plug 'Olical/conjure'
Plug 'cespare/vim-toml'
Plug 'ekalinin/Dockerfile.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jparise/vim-graphql'
Plug 'keith/swift.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/yajs.vim'
Plug 'rescript-lang/vim-rescript'
Plug 'rhysd/vim-goyacc'
Plug 'vim-syntastic/syntastic'
Plug 'rhysd/npm-filetypes.vim'

" Editor utilities
Plug 'guns/vim-sexp'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'vim-test/vim-test'
Plug 'wakatime/vim-wakatime'

call plug#end()

augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
    autocmd BufNewFile,BufRead *.js.es6 set filetype=javascript
    autocmd BufNewFile,BufRead .swcrc set filetype=json
augroup END

autocmd BufWritePost *.go :silent !gofmt -w %

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

colorscheme base16-onedark

noremap <leader>wh <C-w>h
noremap <leader>wl <C-w>l

tnoremap <Esc> <C-\><C-n>

nnoremap <Leader>gs :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>gb :Git blame<CR>

" NERDTree
let NERDTreeShowHidden = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1

" Coc.nvim
set updatetime=300
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" cpp highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" Wakatime
let g:wakatime_PythonBinary = "/usr/bin/python"

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>

set cmdheight=2
set expandtab
set hidden
set inccommand=split
set mouse=a
set nobackup
set nohlsearch
set nowritebackup
set number
set relativenumber
set shiftwidth=2
set tabstop=2
set updatetime=100
set encoding=utf-8
set pyxversion=3
set cc=100
