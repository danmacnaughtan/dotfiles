"---------- Vim-Plug ----------{{{

call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'wincent/terminus'
Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --rust-completer --ts-completer --java-completer --go-completer' }
Plug 'hashivim/vim-terraform'

" Python
Plug 'psf/black', { 'branch': 'stable' }
Plug 'vim-scripts/django.vim'

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
let g:ycm_auto_hover=''
if substitute(system('uname'), '\n', '', '') == 'Darwin'
    let g:ycm_python_binary_path='python3'
else
    let g:ycm_python_binary_path='python'
endif

"}}}

"---------- Rust ----------{{{

let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]

:command CustomCargoFmt execute ':call system("cargo fmt")' | e
autocmd BufWritePost *.rs execute ':CustomCargoFmt'

"}}}

"---------- Go ----------{{{

:command CustomGoFmt execute ':call system("gofmt -w " . bufname("%"))' | e
autocmd BufWritePost *.go execute ':CustomGoFmt'

"}}}

"---------- Racket ----------{{{

let g:syntastic_enable_racket_racket_checker = 1

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
autocmd FileType svelte set tabstop=2 softtabstop=2 shiftwidth=2

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

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

"isort
"let g:vim_isort_map = ''
"autocmd BufWritePre *.py execute ':Isort'
:command CustomIsort execute ':call system("isort --lines-after-imports 2 " . bufname("%"))' | e
autocmd BufWritePost *.py execute ':CustomIsort'

"Black
"autocmd BufWritePre *.py execute ':Black'
:command CustomBlack execute ':call system("~/.vim/black/bin/black " . bufname("%"))' | e
autocmd BufWritePost *.py execute ':CustomBlack'

"}}}

"---------- Java ----------{{{

" Java completer and syntax checker using YCM (jdt.ls) requires JDK11
" https://wiki.archlinux.org/title/Java#Switching_between_JVM

" Disable syntastic checkers in favor of YCM
let g:syntastic_java_checkers = []

" Disable eclim diagnostics in favor of YCM
let g:EclimFileTypeValidate = 0

" Better syntax highlighting
let java_highlight_functions = 1
let java_highlight_all = 1

" Some more highlights...
highlight link javaScopeDecl Statement
highlight link javaType Type
highlight link javaDocTags PreProc

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

let g:c_syntax_for_h = 1

" Allow autocomplete to see functions defined with macros
let g:clang_complete_macros = 1

:command ClangFormat execute '%!/usr/bin/clang-format -style=file'
au FileType h,hpp,c,cpp,cc set tabstop=4 softtabstop=4 shiftwidth=4

let c_no_curly_error = 1

"}}}

"---------- Groff ----------{{{

autocmd! BufNewFile,BufRead *.tr,*.roff,*.groff set ft=groff

"}}}

"---------- GLSL ----------{{{

autocmd! BufNewFile,BufRead *.vs,*.fs set filetype=glsl

"}}}

"---------- Visible tab indents ---------{{{

" toggle with :IndentLinesToggle
"let g:indentLine_enabled = 0
"```set list listchars=tab:»·,trail:·,nbsp:· " Whitespace```

"}}}

"---------- Markdown ---------{{{

" Disable conceallevel for markdown files
autocmd FileType markdown let g:indentLine_setConceal=0
autocmd FileType markdown set conceallevel=0
let g:vim_markdown_folding_disabled = 1

"}}}

"---------- Terraform ---------{{{

let g:terraform_fmt_on_save = 1
let g:terraform_align = 1

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
    "autocmd VimLeave * call system("xclip -sel clip", getreg('+'))
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
