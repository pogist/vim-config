call plug#begin()

" General vim stuff
Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Coc.nvim
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Theme
Plug 'chriskempson/base16-vim'

" Clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }

" JS
Plug 'mattn/emmet-vim'
Plug 'flowtype/vim-flow'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'

" Wakatime
Plug 'wakatime/vim-wakatime'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Objective-C
Plug 'eraserhd/vim-ios'

call plug#end()

" Theme config
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme base16-synth-midnight-dark
set background=dark

" Custom terminal initialization
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

tnoremap <Esc> <C-\><C-n>
command Terminal call StartupTerminal()

function StartupTerminal()
  vsplit term://zsh
  startinsert
endfunction

" Stands for `Git show`
" Toggles git changes highlight
command Gs GitGutterLineHighlightsToggle

" Clojure
let g:clojure_align_multiline_strings = 1
let g:clojure_align_subforms = 1

" Flow
let g:javascript_plugin_flow = 1
let g:flow#enable = 1
let g:flow#autoclose = 1

" NERDTree
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

" NERDCommenter
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1

" markdown
let g:mkdp_auto_start = 1

set hidden
set number
set relativenumber
set mouse=a
set inccommand=split
set tabstop=2
set shiftwidth=2
set expandtab
set updatetime=100
set cc=80
set nobackup
set nowritebackup
set cmdheight=2
