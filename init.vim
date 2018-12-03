call plug#begin()

" General vim stuff
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'euclio/vim-markdown-composer'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Theme
Plug 'joshdick/onedark.vim'

" Clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-dispatch', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }

" JS
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow'

" Wakatime
Plug 'wakatime/vim-wakatime'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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

colorscheme onedark
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

" JSX
let g:jsx_ext_required = 0

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>

" Find occurrences of the word that's under cursor
nnoremap <leader>f :Ag <C-R><C-W>

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
