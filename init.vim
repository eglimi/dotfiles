"if $SHELL =~ 'bin/fish'
"	set shell=/bin/sh
"endif

" General settings
set tenc=utf8    "terminal encoding is UTF-8
set enc=utf8     "character encoding is UTF-8
set laststatus=2 "always show status line
set bs=2         "backspace handling

" Use ripgrep for grepping
set grepprg=rg\ --vimgrep

" Numbering
set number         "show line numbers
set colorcolumn=100 " 100 columns per line
set relativenumber
set inccommand=split "live substitution

" Leader Key is SPC
let mapleader="\<Space>"

" vim-plug
call plug#begin('$HOME/.config/nvim/bundle')
let g:plug_threads = 4

" Plugins

Plug 'sheerun/vim-polyglot'

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

"Plug 'majutsushi/tagbar'
Plug 'jlanzarotta/bufexplorer'
" Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimfiler.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
Plug 'carlitux/deoplete-ternjs'

"Plug 'Valloric/YouCompleteMe'
"Plug 'lyuts/vim-rtags'
Plug 'benekastah/neomake'
Plug 'wting/rust.vim'
Plug 'fatih/vim-go'
Plug 'awetzel/elixir.nvim'
Plug 'vim-scripts/Arduino-syntax-file'
Plug 'othree/javascript-libraries-syntax.vim'

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'

Plug 'mhinz/vim-signify'
Plug 'bling/vim-airline'
Plug 'chazy/cscope_maps'
Plug 'sjl/gundo.vim'
Plug 'vim-scripts/Colour-Sampler-Pack'
Plug 'godlygeek/tabular'

Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'romainl/Apprentice'
Plug 'dracula/vim'

Plug 'vim-scripts/gnupg.vim'

call plug#end()

au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
au BufRead,BufNewFile *.md set filetype=markdown

" undo
set undofile
nnoremap <Leader>gu :GundoToggle<CR>

" Syntax
syntax on
filetype plugin indent on
set ts=2
set sw=2
" set expandtab
"nmap <Leader>ff :%!astyle --style=stroustrup --indent=tab --indent-switches --unpad-paren --keep-one-line-statements --keep-one-line-blocks --align-pointer=type --lineend=linux --suffix=none --quiet<CR>

" Toggle highlight bg in insert mode
:autocmd InsertEnter * set nocul
:autocmd InsertLeave * set cul

" Menu / Completion
" set wildmenu
" set wildmode=list:longest,full
" set completeopt=preview,menuone,menu,longest
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" do not resize other windows when closing the preview window
set noequalalways

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:clang_complete_auto = 1
let g:clang_auto_select = 0
let g:clang_make_default_keymappings = 0
nnoremap <F5> :call g:ClangUpdateQuickFix()<CR>
let g:clang_library_path = "/usr/lib/llvm-3.7/lib/libclang.so.1"

" Gitv
let g:Gitv_OpenHorizontal = 1

" youcompleteme
autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_rust_src_path = '/usr/local/rust-src/src'

" Search / Highlight
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set showcmd
set cursorline

" Colours
set termguicolors
colorscheme dracula
set background=dark
" before: wombat

" ctags
" Build tags of your own project with leader-tt
nmap <Leader>tc :call UpdateTags()<CR>


" file / buffer handling
nmap <silent> <Leader>ft :NERDTreeToggle<CR>
nmap <silent> <Leader>ff :NERDTreeFind<CR>
nmap <silent> <Leader>tt :TagbarToggle<CR>
nmap <silent> <Leader>bb :ToggleBufExplorer<CR>

" terminal mode mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Clang format
nmap <C-K> :pyf /usr/share/vim/addons/syntax/clang-format-3.8.py<cr>
nmap <Leader>bf :!clang-format-3.8 -style=file -i %:p<cr>:e %<cr>

" vim-airline
let g:airline_powerline_fonts = 1

" go-vim
au FileType go nmap <Leader>gd <Plug>(go-doc)

" git mappings
nmap <Leader>gv :!cd %:p:h ; find . -name "%:t" -exec gitk --all {} \; &<CR><CR>
nmap <Leader>ga :!cd %:p:h ; gitk --all &<CR><CR>
nmap <Leader>gg :!cd %:p:h ; git gui &<CR><CR>
nmap <Leader>gt :!cd %:p:h ; find . -name "%:t" -exec tig -- {} \;<CR><CR>
nmap <Leader>gi :!tig<CR><CR>

" Functions
func UpdateTags()
	execute "!ctags -R --sort=foldcase --c++-kinds=+p --fields=+iaS --extra=+q ."
	execute "!cscope -b -R"
endfunc

" fzf
nmap <silent> <C-p> :GitFiles<CR>
nmap <leader><Space> <plug>(fzf-maps-n)
" let g:fzf_layout = { 'window': 'enew' }
"nnoremap <C-p> :FuzzyOpen<CR>

" denite
" Change mappings.
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#var('grep', 'command', ['rg'])
nnoremap <silent> <Leader>uf :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>ub :<C-u>Denite buffer<CR>
nnoremap <silent> <Leader>uj :<C-u>Denite outline<CR>
nnoremap <silent> <Leader>/ :<C-u>Denite grep:.<CR>

