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
set relativenumber
set colorcolumn=100 " 100 columns per line
set inccommand=split "live substitution

" Leader Key is SPC
let mapleader="\<Space>"

" vim-plug
call plug#begin('$HOME/.config/nvim/bundle')
let g:plug_threads = 8

" Plugins

Plug 'sheerun/vim-polyglot'

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

"Plug 'majutsushi/tagbar'
Plug 'jlanzarotta/bufexplorer'
" Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go'
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-clang'
Plug 'Shougo/neoinclude.vim'

" Languages
"Plug 'Valloric/YouCompleteMe'
"Plug 'lyuts/vim-rtags'
Plug 'benekastah/neomake'
Plug 'wting/rust.vim'
Plug 'fatih/vim-go'
Plug 'elixir-lang/vim-elixir'
Plug 'thinca/vim-ref'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
Plug 'vim-scripts/Arduino-syntax-file'
Plug 'othree/javascript-libraries-syntax.vim'

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'
Plug 'idanarye/vim-merginal'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'chazy/cscope_maps'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'sjl/gundo.vim'
Plug 'vim-scripts/Colour-Sampler-Pack'
Plug 'junegunn/vim-easy-align'

Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'romainl/Apprentice'

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
let g:deoplete#sources#clang#libclang_path = "/usr/lib/llvm-3.9/lib/libclang.so.1"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang/3.9/include"
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
set noshowmode " don't show mode, we use statusline

" statusline / lightline
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'fugitive', 'readonly', 'winnbr', 'filename', 'modified' ] ]
	\ },
	\ 'inactive': {
	\   'left': [ [ 'winnbr', 'filename' ] ]
	\ },
	\ 'component_function': {
	\   'winnbr': 'LightlineWinNbr',
	\   'fugitive': 'LightlineFugitive',
	\   'readonly': 'LightlineReadonly',
	\   'modified': 'LightlineModified'
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
	\ }

function! LightlineWinNbr()
	let nbr = tabpagewinnr(tabpagenr())
	return '# '.nbr
endfunction

function! LightlineFugitive()
	if exists("*fugitive#head")
		let branch = fugitive#head()
		return branch !=# '' ? ' '.branch : ''
	endif
	return ''
endfunction

function! LightlineReadonly()
	if &readonly
		return ""
	else
		return ""
	endif
endfunction

function! LightlineModified()
	if &modified
		return "+"
	else
		return ""
	endif
endfunction

let i = 1
while i <= 9
	execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
	let i = i + 1
endwhile

" Colours
set termguicolors
set background=dark
colorscheme gruvbox
" hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
" hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE
" before: wombat

let g:gruvbox_italicize_comments=0
let g:gruvbox_invert_selection=0

" ctags
" Build tags of your own project with leader-tt
nmap <Leader>tc :call UpdateTags()<CR>


" file / buffer handling
nmap <silent> <Leader>ft :NERDTreeToggle<CR>
nmap <silent> <Leader>ff :NERDTreeFind<CR>
nmap <silent> <Leader>tt :TagbarToggle<CR>

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
nmap <C-K> :pyf /usr/share/vim/addons/syntax/clang-format.py<cr>
nmap <Leader>fc :!clang-format -style=file -i %:p<cr>:e %<cr>

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
"nmap <silent> <C-p> :GitFiles<CR>
nmap <leader><Space> <plug>(fzf-maps-n)
nmap <leader>w :call fzf#vim#windows(0)<CR>
" let g:fzf_layout = { 'window': 'enew' }
"nnoremap <C-p> :FuzzyOpen<CR>

" denite
" Change mappings.
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <C-p> :<C-u>Denite `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>
nnoremap <silent> <Leader>bb :<C-u>Denite buffer<CR>
nnoremap <silent> <Leader>bj :<C-u>Denite outline<CR>
nnoremap <silent> <Leader>/ :<C-u>Denite grep:.<CR>

