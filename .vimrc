"---------- Vim-Plug ----------{{{

call plug#begin('~/.vim/plugged')

" General improvements
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'wincent/terminus'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'

" Autocomplete
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --ts-completer --rust-completer --java-completer' }

" Python
Plug 'nvie/vim-flake8'
Plug 'vim-scripts/indentpython.vim'
" Due to issue: https://github.com/psf/black/issues/1304
Plug 'psf/black', { 'commit': 'ce14fa8b497bae2b50ec48b3bd7022573a59cdb1' }
Plug 'fisadev/vim-isort'

" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Other language support
Plug 'vim-scripts/django.vim'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'posva/vim-vue'
Plug 'mxw/vim-jsx'
Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'rhysd/vim-crystal'
Plug 'cespare/vim-toml'

call plug#end()

"}}}

"---------- YCM  ----------{{{

let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_min_num_of_chars_for_completion=4
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_global_ycm_extra_conf='~/.ycm/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_max_diagnostics_to_display = 1000
if substitute(system('uname'), '\n', '', '') == 'Darwin'
    let g:ycm_python_binary_path='python3'
else
    let g:ycm_python_binary_path='python'
endif

"}}}

"---------- Rust ----------{{{

let g:ycm_rust_src_path=system('rustc --print sysroot')+'/lib/rustlib/src/rust/src'

"}}}

"---------- Ruby ----------{{{

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"autocmd FileType ruby,eruby set tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType ruby,eruby set tabstop=2 softtabstop=2 shiftwidth=2

"}}}

"---------- JavaScript ----------{{{

let g:vim_json_syntax_conceal = 0

autocmd FileType css,html,vue set tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType json set tabstop=4 softtabstop=4 shiftwidth=4
"autocmd FileType javascript set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2

" Vue specific highlighting fix
autocmd FileType vue syntax sync fromstart

"}}}

"---------- Django ----------{{{

autocmd FileType htmldjango set tabstop=2 softtabstop=2 shiftwidth=2

"}}}

"---------- Custom Keys ----------{{{

let mapleader = " "

map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <leader>h :YcmCompleter GetDoc<CR>
map <leader>t :NERDTreeToggle<CR>

map <leader>w :set tw=90<CR>:set linebreak<CR>:set spell spelllang=en_us<CR>
map <leader>W :set tw=90<CR>:set nolinebreak<CR>:set nospell<CR>

" Start FZF (if installed)
if substitute(system('uname'), '\n', '', '') == 'Darwin'
    set rtp+=/usr/local/opt/fzf
endif
map <C-p> :FZF<CR>

"}}}

"---------- Custom Commands ----------{{{

" Here is a command for auto-formatting json
:command FormatJSON execute '%!python -m json.tool' | w

" Command for quickly setting django-template filetype
:command DjangoSetFiletype execute ':setfiletype htmldjango'

" YCM FixIt command
:command FixIt execute ':YcmCompleter FixIt'

"}}}

"---------- Makefile ----------{{{

" Remove expandtab for makefiles
autocmd FileType Makefile set noexpandtab

"}}}

"---------- Python ----------{{{

" Make python code look pretty
let python_highlight_all=1

" flake8 setup
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

" Favor Python 3 syntax
let g:syntastic_python_python_exec = 'python3'

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

"}}}

"---------- Docker ----------{{{

" Syntax highlighting for Dockerfiles with custom names (e.g., 'Dockerfile-foobar')
au BufNewFile,BufRead Dockerfile* set filetype=dockerfile

"}}}

"---------- ASM ----------{{{

autocmd BufNewFile,BufRead *.asm set filetype=nasm
let asmsyntax="nasm"
let g:syntastic_nasm_nasm_args = '-f elf32'

"}}}

"---------- Clang/C/C++ ----------{{{

" Allow autocomplete to see functions defined with macros
let g:clang_complete_macros = 1

:command ClangFormat execute '%!/usr/bin/clang-format -style=file'
autocmd FileType h,hpp,c,cpp,cc set tabstop=4 softtabstop=4 shiftwidth=4

"}}}

"---------- Black ----------{{{

"let g:black_linelength = 99
"let g:black_skip_string_normalization = 1
"autocmd BufWritePre *.py execute ':Black'

" I think Black is working on finding the pyproject.toml when running `:Black`, but ATM
" this isn't working. As a workaround, we can use the following to allow post save and use
" any pyproject.toml config:
:command CustomBlack execute ':call system("~/.vim/black/bin/black " . bufname("%"))' | e
autocmd BufWritePost *.py execute ':CustomBlack'

"}}}

"---------- isort ----------{{{

let g:vim_isort_map = ''
autocmd BufWritePre *.py execute ':Isort'

"}}}

"---------- Visible tab indents ---------{{{

" toggle with :IndentLinesToggle
"let g:indentLine_enabled = 0
"```set list listchars=tab:»·,trail:·,nbsp:· " Whitespace```

"}}}

"---------- Markdown ---------{{{

" Disable conceallevel for markdown files
autocmd FileType markdown let g:indentLine_setConceal = 0
let g:vim_markdown_folding_disabled = 1

"}}}

"---------- Vimrc ----------{{{

autocmd BufNewFile,BufRead *vimrc set foldmethod=marker

"}}}

"---------- General ----------{{{

set textwidth=90

" Clipboard
if substitute(system('uname'), '\n', '', '') == 'Darwin'
    " System clipboard using '+' register
    set clipboard=unnamed
else
    " System clipboard using '*' register
    set clipboard=unnamedplus
    " Prevent copied text from being removed from the clipboard when vim closes
    autocmd VimLeave * call system("xclip -sel clip", getreg('+'))
endif

" Remove swap file
set noswapfile

" UTF8 Support
set encoding=utf-8

" Tab configurations
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set smarttab
set cindent
filetype indent on

" Highlight search results
set hlsearch

" Show the cursor line
set cursorline

" improve backspace behavior
set backspace=indent,eol,start

" Disable middle mouse paste
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>

" Keeps statusline visible when using itchyny/lightline.vim
set laststatus=2
" set ruler

" Working without word wrap
set nowrap
set sidescroll=5

" Disable comment auto-formatting
autocmd FileType * setlocal formatoptions-=cro

"}}}

"---------- Themes/Appearance ----------{{{

set t_Co=256
set number
syntax on
syntax enable
set background=dark

let g:jellybeans_overrides = {'background':{'ctermbg':'none','256ctermbg':'none'}}
colorscheme jellybeans

"}}}
