"if $SHELL =~ 'bin/fish'
"	set shell=/bin/sh
"endif

" General settings
set tenc=utf8    "terminal encoding is UTF-8
set enc=utf8     "character encoding is UTF-8
set laststatus=2 "always show status line
set bs=2         "backspace handling

" Numbering
set number         "show line numbers
set colorcolumn=100 " 100 columns per line
set relativenumber

" vim-plug
call plug#begin('$HOME/.config/nvim/bundle')
let g:plug_threads = 4

" Plugins
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim'

Plug 'majutsushi/tagbar'
Plug 'jlanzarotta/bufexplorer'
" Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/vimfiler.vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim'
"Plug 'Rip-Rip/clang_complete'
Plug 'Valloric/YouCompleteMe'
Plug 'benekastah/neomake'
Plug 'elixir-lang/vim-elixir'
Plug 'wting/rust.vim'
Plug 'fatih/vim-go'
Plug 'lambdatoast/elm.vim'
Plug 'vim-scripts/Arduino-syntax-file'

Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'

Plug 'mhinz/vim-signify'
Plug 'bling/vim-airline'
Plug 'chazy/cscope_maps'
Plug 'sjl/gundo.vim'
Plug 'vim-scripts/Colour-Sampler-Pack'
Plug 'morhetz/gruvbox'
Plug 'godlygeek/tabular'

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
"let g:deoplete#enable_at_startup = 1
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

" syntastic
let g:syntastic_cpp_compiler_options="-std=c++11 -Wall -Wextra"

" Search / Highlight
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set showcmd
set cursorline

" Colours
colorscheme gruvbox
set background=dark
" before: wombat

" Runtime settings
runtime ftplugin/man.vim

" ctags
" Build tags of your own project with leader-tt
nmap <Leader>tt :call UpdateTags()<CR>


" file / buffer handling
nmap <silent> <Leader>ntt :NERDTreeToggle<CR>
nmap <silent> <Leader>ntf :NERDTreeFind<CR>
nmap <silent> <Leader>tb :TagbarToggle<CR>

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
nmap <C-K> :pyf /usr/share/vim/addons/syntax/clang-format-3.7.py<cr>
nmap <Leader>cf :!clang-format-3.7 -style=file -i %:p<cr>:e %<cr>

" vim-airline
let g:airline_powerline_fonts = 1

" go-vim
au FileType go nmap <Leader>gd <Plug>(go-doc)

" git mappings
nmap <Leader>gv :!cd %:p:h ; find . -name "%:t" -exec gitk --all {} \; &<CR><CR>
nmap <Leader>ga :!cd %:p:h ; gitk --all &<CR><CR>
nmap <Leader>gg :!cd %:p:h ; git gui &<CR><CR>
nmap <Leader>tv :!cd %:p:h ; find . -name "%:t" -exec tig -- {} \;<CR><CR>
nmap <Leader>ta :!tig<CR><CR>

" Functions
func UpdateTags()
	execute "!ctags -R --sort=foldcase --c++-kinds=+p --fields=+iaS --extra=+q ."
	execute "!cscope -b -R"
endfunc

" fzf
nmap <silent> <C-p> :GitFiles<CR>
" let g:fzf_layout = { 'window': 'enew' }

" unite
nnoremap <silent> ,ff :<C-u>Unite -no-split -start-insert -buffer-name=unite-file file_rec/neovim<CR>
nnoremap <silent> ,fr :<C-u>Unite -no-split -start-insert -buffer-name=unite-file file_rec/async<CR>
nnoremap <silent> ,fg :<C-u>Unite -no-split -start-insert -buffer-name=unite-file file_rec/git:--cached:--others:--exclude-standard<CR>
nnoremap <silent> ,b :<C-u>Unite -no-split -buffer-name=unite-buffer buffer<CR>
nnoremap <silent> ,g :<C-u>Unite -no-split -buffer-name=unite-grep grep:.<CR>

" call unite#custom#source('file_rec/neovim', 'matchers', 'matcher_fuzzy')

if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
	let g:unite_source_rec_async_command = 
				\ ['pt', '--nogroup', '--nocolor', '-l', '']
endif
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

