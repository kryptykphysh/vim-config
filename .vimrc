" Colours {
	syntax enable			    " enable syntax processing
	colorscheme badwolf
	set termguicolors
" }
        
" Tabs and spaces {
  set encoding=utf-8
	set tabstop=2			    " number of visual spaces per TAB
	set softtabstop=2		  " number of spaces in TAB when editing
	set expandtab			    " convert TABs to spaces
  filetype indent on    " load filetype specific indent files
  filetype plugin on

    " Language specific options {
        augroup configgroup
            autocmd!
            autocmd VimEnter * highlight clear SignColumn
            autocmd BufWritePre *.php,*.py,*.txt,*.hs,*.java,*.md,*.rb
                        \:call <SID>StripTrailingWhitespaces()
            autocmd FileType java setlocal noexpandtab
            autocmd FileType java setlocal list
            autocmd FileType java setlocal listchars=tab:+\ ,eol:-
            autocmd FileType java setlocal formatprg=par\ -w80\ -T4
            autocmd FileType javascript setlocal tabstop=2
            autocmd FileType javascript setlocal autoindent
            autocmd FileType javascript setlocal shiftwidth=2
            autocmd FileType javascript setlocal softtabstop=2
            autocmd FileType javascript setlocal expandtab
            autocmd FileType javascript setlocal commentstring=//\ %s
            autocmd FileType typescript setlocal tabstop=2
            autocmd FileType typescript setlocal autoindent
            autocmd FileType typescript setlocal shiftwidth=2
            autocmd FileType typescript setlocal softtabstop=2
            autocmd FileType typescript setlocal expandtab
            autocmd FileType typescript setlocal commentstring=//\ %s
            autocmd FileType json setlocal autoindent
            autocmd FileType json setlocal formatoptions=tcq2
            autocmd FileType json setlocal textwidth=78 shiftwidth=2
            autocmd FileType json setlocal softtabstop=2 tabstop=8
            autocmd FileType json setlocal expandtab
            autocmd FileType json setlocal foldmethod=syntax
            autocmd FileType php setlocal expandtab
            autocmd FileType php setlocal list
            autocmd FileType php setlocal listchars=tab:+\ ,eol:-
            autocmd FileType php setlocal formatprg=par\ -w80\ -T4
            autocmd FileType ruby setlocal tabstop=2
            autocmd FileType ruby setlocal autoindent
            autocmd FileType ruby setlocal shiftwidth=2
            autocmd FileType ruby setlocal softtabstop=2
            autocmd FileType ruby setlocal expandtab
            autocmd FileType ruby setlocal commentstring=#\ %s
            autocmd FileType *.rb setlocal autoindent
            autocmd FileType *.rb setlocal tabstop=2
            autocmd FileType *.rb setlocal shiftwidth=2
            autocmd FileType *.rb setlocal softtabstop=2
            autocmd FileType *.rb setlocal expandtab
            autocmd FileType *.rb setlocal commentstring=#\ %s
            autocmd FileType python setlocal commentstring=#\ %s
            autocmd BufEnter *.cls setlocal filetype=java
            autocmd BufEnter *.zsh-theme setlocal filetype=zsh
            autocmd BufEnter Makefile setlocal noexpandtab
            autocmd BufEnter *.sh setlocal tabstop=2
            autocmd BufEnter *.sh setlocal shiftwidth=2
            autocmd BufEnter *.sh setlocal softtabstop=2
            " add yaml stuffs
            au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
            autocmd FileType yaml setlocal tabstop=2
            autocmd FileType yaml setlocal shiftwidth=2
            autocmd FileType yaml setlocal expandtab
            autocmd FileType go setlocal tabstop=4
            autocmd FileType go setlocal shiftwidth=4
            autocmd FileType go setlocal expandtab
            autocmd FileType xml setlocal tabstop=2
            autocmd FileType xml setlocal shiftwidth=2
            autocmd FileType xml setlocal expandtab
            autocmd FileType xml let g:xml_syntax_folding=1
            autocmd FileType xml setlocal foldmethod=syntax
            autocmd FileType xml :syntax on
            autocmd FileType xml :%foldopen!
    augroup END
    " }
" }

" UI {
  let NERDTreeShowHidden=1    " allow NERDTree to display dot files
	set number relativenumber   " show line numbers
    " Toggle to absolute line numbers when pane loses focus
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set number norelativenumber
    augroup END

	set showcmd			        " show command in bottom bar (covered by Airline)
	set cursorline			    " highlight current line
    set wildmenu                " enable autocomplete for command menu
    set lazyredraw              " only redraw when we need to
    set showmatch               " highlight matching [{()}]
    set incsearch               " search as characters are entered
    set hlsearch                " highlight search matches
    " Code folding {
        set foldenable          " enable folding, duh
        set foldlevelstart=10   " have most folds open by default
        set foldnestmax=10      " 10 nested fold max. If you need more, something's gone wrong
        set foldmethod=indent   " I may change this to syntax in the future
    " }
" }

" TMUX {
    " Allows cursor change in tmux mode
    if exists('$TMUX')
            let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
            let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    else
            let &t_SI = "\<Esc>]50;CursorShape=1\x7"
            let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
" }

" Backups {
    " Save backups in /tmp
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set backupskip=/tmp/*,/private/tmp/*
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set writebackup
" }

source ~/.vim/plugins.vim		" Load vim-plug and plugins
" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' }) " Use omni completion for Go files

" Key remappings {
    " Swap arrow keys to pane navigation in normal mode
	nnoremap <Right> <C-w>l
	nnoremap <Left> <C-w>h
	nnoremap <Up> <C-w>k
	nnoremap <Down> <C-w>j

	" Disable arrow keys in insert mode
	inoremap <Right> <Nop>
	inoremap <Left> <Nop>
	inoremap <Up> <Nop>
	inoremap <Down> <Nop>

    " Clear search highlighting with \<space>
    nnoremap <leader><space> :nohlsearch<CR>
" }
