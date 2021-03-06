" set environment
" set runtimepath=~/.vim,~/.vim/plugged,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

" be iMproved
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/ConradIrwin/vim-bracketed-paste'
Plug 'https://github.com/scrooloose/syntastic'
Plug 'https://github.com/Shougo/neocomplete.vim'
Plug 'https://github.com/lervag/vimtex'
Plug 'https://github.com/PotatoesMaster/i3-vim-syntax'
Plug 'https://github.com/leissa/vim-acme'

call plug#end()
" end vim-plug

filetype plugin indent on    " required

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=10000	" keep 10000 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" display incomplete commands
set incsearch		" do incremental searching
set number			" show line numbers
set cursorline		" show cursor line
set hlsearch		" highlight search words
"set noshowmode
set nostartofline
set wildmenu
set wildmode=longest:full,full
set pastetoggle=<Ins>
set foldmethod=indent
set foldlevel=99

set ts=4
set shiftwidth=4 

setlocal fo+=aw         " format type for mails
set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8
let python_highlight_all=1
syntax on

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" toggle search highlighting
nnoremap <silent><expr> <F3> (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" textwidth for special filetypes on laptop screen
autocmd FileType text setlocal textwidth=189                                        
autocmd FileType tex setlocal textwidth=189
autocmd FileType vim setlocal textwidth=189
autocmd FileType config setlocal textwidth=189
autocmd FileType sh setlocal textwidth=189
autocmd BufNewFile,BufRead * if expand('%:t') !~ '\.' | setlocal textwidth=189 | endif	" set all files without extension to textwidth 189

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" airline
set laststatus=2
let g:airline_theme='serene'
let g:airline_powerline_fonts = 1

" colorscheme 
colorscheme Tomorrow-Night-Bright
hi Normal ctermbg=black

" spell check
set spelllang=de 

" delimitMate
let delimitMate_expand_cr = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Emmet HTML CSS
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" NeoComplete
" -------------------------------------------------------------------------------------

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
\ 'default' : '',
\ 'vimshell' : $HOME.'/.vimshell_hist',
\ 'scheme' : $HOME.'/.gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()


" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}}}

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] *\t]\.'

" -------------------------------------------------------------------------------------
" End NeoComplete

