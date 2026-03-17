" Kent's NeoVim init.vim
" Kent Huang <kentwelcome@gmail.com>
" Translated from vim/vimrc for NeoVim

" General Settings
set bs=2              " allow backspacing over everything in insert mode
set history=50        " keep 50 lines of command line history
set ruler             " show the cursor position all the time
set autoread          " auto read when file is changed from outside

filetype on
filetype plugin on

syntax on             " syntax highlight
set hlsearch          " search highlighting
set background=dark
" set termguicolors   " disabled to match Vim's terminal color appearance
colorscheme ir_black

" Force NeoVim to use terminal background (match Vim appearance)
highlight Normal guibg=NONE ctermbg=NONE
highlight NonText guibg=NONE ctermbg=NONE
highlight EndOfBuffer guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

" Cursor and visual highlighting
set cursorline
highlight CursorLine guibg=#003853 ctermbg=24 gui=none cterm=none
highlight Visual     guibg=#003853 ctermbg=24 gui=none cterm=none

set clipboard=unnamedplus  " yank to system clipboard (NeoVim prefers unnamedplus)
set showmatch         " Cursor shows matching ) and }
set showmode          " Show current mode
set wildchar=<TAB>    " start wild expansion in the command line using <TAB>
set wildmenu          " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent        " auto indentation
set incsearch         " incremental search
set nobackup          " no *~ backup files
set copyindent        " copy the previous indentation on autoindenting
set ignorecase        " ignore case when searching
set smartcase         " ignore case if search pattern is all lowercase
set smarttab          " insert tabs on the start of a line according to context

" disable sound on errors
set noerrorbells
set novisualbell

" TAB setting
set expandtab         " replace <TAB> with spaces
set softtabstop=4
set shiftwidth=4
au FileType Makefile set noexpandtab

" status line
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
set statusline+=\ \ \ [%{&ff}/%Y]
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

" C/C++ specific settings
autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

" Restore cursor to file position in previous editing session
set shada='10,\"100,:20,%,n~/.local/state/nvim/shada/main.shada
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------
filetype off                   " required!
set rtp+=~/.config/nvim/bundle/vundle/
call vundle#rc('~/.config/nvim/bundle')

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" --- Plugins ---
" powerline is incompatible with NeoVim's Python 3
" NOTE: For Lua-native option, consider lualine.nvim
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'

Bundle 'chazy/cscope_maps'
" NOTE: NeoVim alternative -> built-in LSP for code navigation

Bundle 'vim-scripts/ctags.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'wesleyche/SrcExpl'
Bundle 'wesleyche/Trinity'
" NOTE: NeoVim alternative -> nvim-tree.lua + telescope.nvim for file/symbol navigation

Bundle 'vim-scripts/AutoComplPop'
Bundle 'vim-scripts/neocomplcache'
" NOTE: NeoVim alternative -> nvim-cmp + built-in LSP for completion

Bundle 'vim-scripts/snipMate'
" NOTE: NeoVim alternative -> LuaSnip

" fakeclip not needed -- NeoVim has native clipboard support
" Bundle 'vim-scripts/fakeclip'

Bundle 'vim-scripts/surround.vim'
Bundle 'c9s/bufexplorer'
" NOTE: NeoVim alternative -> telescope.nvim for buffer management

Bundle 'dag/vim-fish'
Plugin 'fatih/vim-go'
Plugin 'editorconfig/editorconfig-vim'

filetype plugin indent on     " required!

set autoindent
set number
nnoremap <F3> :set nonumber!<CR>

" Trinity panel toggles
nnoremap <F12> :TrinityToggleAll<CR>
nmap <F9> :TrinityToggleSourceExplorer<CR>
nmap <F8> :TrinityToggleTagList<CR>
nmap <F7> :TrinityToggleNERDTree<CR>

" Cscope hot keys
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

set showcmd
set ruler

" Indenting
set ai                " auto indent
set si                " smart indent
" pastetoggle not needed -- NeoVim handles paste automatically

" Airline (powerline replacement)
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'
