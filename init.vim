call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

Plug 'HerringtonDarkholme/yats.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml'
Plug 'chriskempson/base16-vim'
Plug 'clangd/coc-clangd', { 'do': 'yarn install --frozen-lockfile' }
Plug 'ekalinin/Dockerfile.vim'
Plug 'fannheyward/coc-marketplace', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-pyright', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-rust-analyzer', { 'do': 'yarn install --frozen-lockfile' }
Plug 'flowtype/vim-flow'
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-sexp'
Plug 'iamcco/coc-diagnostic', { 'do': 'yarn install --frozen-lockfile' }
Plug 'iamcco/coc-vimlsp', { 'do': 'yarn install --frozen-lockfile' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jiangmiao/auto-pairs'
Plug 'josa42/coc-go', { 'do': 'yarn install --frozen-lockfile' }
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'keith/swift.vim'
Plug 'klaaspieter/coc-sourcekit', { 'do': 'yarn install --frozen-lockfile' }
Plug 'mattn/emmet-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/coc-css', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-emmet', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-eslint', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-html', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-json', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-prettier', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-snippets', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-solargraph', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-tsserver', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-yaml', { 'do': 'yarn install --frozen-lockfile' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'othree/yajs.vim'
Plug 'rescript-lang/vim-rescript'
Plug 'rhysd/vim-goyacc'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-test/vim-test'
Plug 'wakatime/vim-wakatime'

call plug#end()

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
command Terminal call StartupTerminal()

function StartupTerminal()
  vsplit term://zsh
  startinsert
endfunction

nnoremap <Leader>gs :GitGutterLineHighlightsToggle<CR>
nnoremap <Leader>gb :Gblame<CR>

let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 1

augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
    autocmd BufNewFile,BufRead *.js.es6 set filetype=javascript
augroup END

let NERDTreeShowHidden = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Coc.nvim
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1

let g:mkdp_auto_start = 1

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

let g:wakatime_PythonBinary = "/usr/bin/python"

autocmd BufWritePost *.go :silent !gofmt -w %

imap <C-j> <Plug>(coc-snippets-expand)

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
