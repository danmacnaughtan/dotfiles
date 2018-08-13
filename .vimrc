"---------- Vundle ----------
set nocompatible " required
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add all your plugins here

" python syntax checking
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
" autocomplete
" Don't forget to navigate to ~/.vim/bundle/YouCompleteMe,
" and execute ./install.sh --clang-completer 
Plugin 'Valloric/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
" filesystem
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
" Swift support
Plugin 'toyamarinyon/vim-swift'
" Vim enhanced (with mouse improvments)
Plugin 'wincent/terminus'
" Ruby support
Plugin 'vim-ruby/vim-ruby'
" JavaScript support
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'elzr/vim-json'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin '1995eaton/vim-better-javascript-completion'

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required


"-------- Configuring auto-complete plugin --------
let g:ycm_seed_identifiers_with_syntax=1 " not sure what this is for
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_min_num_of_chars_for_completion=4
let g:ycm_global_ycm_extra_conf='~/.ycm/.ycm_extra_conf.py'
" find the right python for the completion
let g:ycm_python_binary_path = 'python'
"let g:ycm_python_binary_path = '/usr/local/bin/python3'


"---------- Ruby Config ----------
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" For rails style using tabs with 2 spaces
autocmd FileType ruby,eruby,html set tabstop=2 softtabstop=2 shiftwidth=2


"---------- JavaScript Config ----------
" Basic omnifunc autocompletion for javascript
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" Front-end devs seem to like using tabs with 2 spaces
autocmd FileType javascript,json,css set tabstop=2 softtabstop=2 shiftwidth=2
" Enabled by default. flip the value to make completion matches case insensitive
let g:vimjs#casesensistive = 1
" Disabled by default. Enabling this will let vim complete matches at any location
" e.g. typing 'ocument' will suggest 'document' if enabled.
let g:vimjs#smartcomplete = 1
" Disabled by default. Toggling this will enable completion for a number of Chrome's JavaScript extension APIs
let g:vimjs#chromeapis = 1
" disable json syntax conceal
let g:vim_json_syntax_conceal = 0


"---------- Custom Keys ----------
let mapleader = " "
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>h :YcmCompleter GetDoc<CR>
map <leader>t :NERDTreeToggle<CR>

" Here is my writting notes mode, on and off
map <leader>w :set tw=80<CR>:set linebreak<CR>:set spell spelllang=en_us<CR>
map <leader>W :set tw=0<CR>:set nolinebreak<CR>:set nospell<CR>

" toggle ycm on and off
"nnoremap <leader>y :let g:ycm_auto_trigger=0<CR> " turn off ycm
"nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR> " turn on ycm


"---------- Custom Commnads ----------
" Here is a command for autoformatting json
:command FormatJSON execute '%!python -m json.tool' | w


"---------- Makefile Config ----------
" Remove expandtab for makefiles
autocmd FileType Makefile set noexpandtab


"---------- Swift Config ----------
" syntastic for swift
let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']


"---------- Python Config ----------
" Make python code look pretty
let python_highlight_all=1

" flake8 setup
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix


"---------- General Config ---------
" use the system clipboard
" for systems using the '+' register
"set clipboard=unnamedplus 
" for systems using the '*' register
"set clipboard=unnamed
if substitute(system('uname'), '\n', '', '') == 'Darwin'
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" remove swap file
set noswapfile

" UTF8 Support
set encoding=utf-8

" tab configurations
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set smarttab
set cindent
filetype indent on

set hlsearch
set cursorline

" improve backspace behavior
set backspace=indent,eol,start

" Disable middle mouse paste
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>


"---------- Themes/Appearance ----------
set number
syntax on
syntax enable
set background=dark

" Jellybeans
let g:jellybeans_overrides = {'background':{'ctermbg':'none','256ctermbg':'none'}}
colorscheme jellybeans

