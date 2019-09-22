" Colours {
	syntax enable			    " enable syntax processing
	colorscheme badwolf
	set termguicolors
" }

" Tabs and spaces {
	set tabstop=4			    " number of visual spaces per TAB
	set softtabstop=4		    " number of spaces in TAB when editing
	set expandtab			    " convert TABs to spaces
    filetype indent on          " load filtype specific indent files

    " Language specific options {
        augroup configgroup
            autocmd!
            autocmd VimEnter * highlight clear SignColumn
            autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                        \:call <SID>StripTrailingWhitespaces()
            autocmd FileType java setlocal noexpandtab
            autocmd FileType java setlocal list
            autocmd FileType java setlocal listchars=tab:+\ ,eol:-
            autocmd FileType java setlocal formatprg=par\ -w80\ -T4
            autocmd FileType php setlocal expandtab
            autocmd FileType php setlocal list
            autocmd FileType php setlocal listchars=tab:+\ ,eol:-
            autocmd FileType php setlocal formatprg=par\ -w80\ -T4
            autocmd FileType ruby setlocal tabstop=2
            autocmd FileType ruby setlocal shiftwidth=2
            autocmd FileType ruby setlocal softtabstop=2
            autocmd FileType ruby setlocal commentstring=#\ %s
            autocmd FileType python setlocal commentstring=#\ %s
            autocmd BufEnter *.cls setlocal filetype=java
            autocmd BufEnter *.zsh-theme setlocal filetype=zsh
            autocmd BufEnter Makefile setlocal noexpandtab
            autocmd BufEnter *.sh setlocal tabstop=2
            autocmd BufEnter *.sh setlocal shiftwidth=2
            autocmd BufEnter *.sh setlocal softtabstop=2
        augroup END
    " }
" }

" UI {
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

source ./.vim/plugins.vim		" Load vim-plug and plugins

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
