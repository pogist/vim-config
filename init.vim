call plug#begin()

" Coc.nvim
let install_pkg = { 'do': 'yarn install --frozen-lockfile' }
let install_coc = extend(install_pkg, { 'branch': 'master' })

Plug 'neoclide/coc.nvim', install_coc
Plug 'clangd/coc-clangd', install_pkg
Plug 'fannheyward/coc-marketplace', install_pkg
Plug 'fannheyward/coc-pyright', install_pkg
Plug 'fannheyward/coc-rust-analyzer', install_pkg
Plug 'iamcco/coc-diagnostic', install_pkg
Plug 'iamcco/coc-vimlsp', install_pkg
Plug 'josa42/coc-go', install_pkg
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

" Appearance
Plug 'chriskempson/base16-vim'
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

" Editor utilities
Plug 'guns/vim-sexp'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
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
imap <C-j> <Plug>(coc-snippets-expand)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:mkdp_auto_start = 1

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
