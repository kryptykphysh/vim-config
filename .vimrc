" vim: set sw=4 ts=4 sts=4 et foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Use bundles config {
    set nocompatible        " Must be first line

    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }

" General {

    set background=dark         " Assume a dark background
    if !has('gui')
        set term=$TERM          " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    if has ('x') && has ('gui') " On Linux use + register for copy-paste
        set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    au FileType crontab set nobackup nowritebackup

    " Setting up the directories {
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif
    " }

" }

" Vim UI {
    let g:solarized_termcolors=16
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="high"

    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        colorscheme solarized
    else
        colorscheme elflord
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background for
    highlight clear LineNr          " Current line number row will have same background color in relative mode.

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=1                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code

    " Highlight problematic whitespace
    set list
    set listchars=tab:>-,trail:.,extends:>,nbsp:.

    " Highlight problems
    let &colorcolumn="80,".join(range(120,999),",")
    hi ColorColumn guibg=#000000 ctermbg=0

    "    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    "    highlight ExtraWhitespace ctermbg=red guibg=red
    "    match ExtraWhitespace /\s\+$\| \+\ze\t/

    " Restore cursor on file open {
        function! ResCur()
            if line("'\"") <= line("$")
                normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    " }
" }

" Formatting {
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set expandtab                   " Tabs are spaces, not tabs
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current

    " Strip whitespace
    autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

    "Tab formatting
    set shiftwidth=2                " Use indents of 4 spaces
    set tabstop=2                   " An indentation every four columns
    set softtabstop=2               " Let backspace delete indent
    autocmd FileType sh,python,php setlocal shiftwidth=4 tabstop=4 softtabstop=4
" }

" Key (re)Mappings {
    " Swap arrow keys to split navigation in normal mode
    nnoremap <Right> <C-w>l
    nnoremap <Left> <C-w>h
    nnoremap <Up> <C-w>k
    nnoremap <Down> <C-w>j

    " Disable arrow keys in insert mode
    inoremap <Right> <Nop>
    inoremap <Left> <Nop>
    inoremap <Up> <Nop>
    inoremap <Down> <Nop>

    " pastetoggle (sane indentation on pastes)
    set pastetoggle=<F12>

    " Toggle NERDTree
    map <F2> :NERDTreeToggle<CR>

    " Remap leader to ','
    let mapleader = ','

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Code folding options
    nmap <Leader>f0 :set foldlevel=0<CR>
    nmap <Leader>f1 :set foldlevel=1<CR>
    nmap <Leader>f2 :set foldlevel=2<CR>
    nmap <Leader>f3 :set foldlevel=3<CR>
    nmap <Leader>f4 :set foldlevel=4<CR>
    nmap <Leader>f5 :set foldlevel=5<CR>
    nmap <Leader>f6 :set foldlevel=6<CR>
    nmap <Leader>f7 :set foldlevel=7<CR>
    nmap <Leader>f8 :set foldlevel=8<CR>
    nmap <Leader>f9 :set foldlevel=9<CR>

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    " http://stackoverflow.com/a/8064607/127816
    vnoremap . :normal .<CR>

    " Fix home and end keybindings for screen, particularly on mac
    " - for some reason this fixes the arrow keys too. huh.
    map ^[[F $
    imap ^[[F ^O$
    map ^[[H g0
    imap ^[[H ^Og0

    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null
" }

" Plugins {

    " PythonMode {
        " Disable if python support not present
        if !has('python')
            let g:pymode = 1
        endif

        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
    " }

    " indentLine {
        let g:indentLine_color_term = 3
    " }

    " vim-airline {
        " Set configuration options for the statusline plugin vim-airline.
        " Use the powerline theme and optionally enable powerline symbols.
        " To use the symbols , , , , , , and .in the statusline
        " segments add the following to your .vimrc.before.local file:
        "   let g:airline_powerline_fonts=1
        " If the previous symbols do not render for you then install a
        " powerline enabled font.
        let g:airline_theme = 'badwolf'
        "let g:airline_powerline_fonts = 1

        if !exists('g:airline_powerline_fonts')
            " Use the default set of separators with a few customizations
            let g:airline_left_sep='›'  " Slightly fancier than '>'
            let g:airline_right_sep='‹' " Slightly fancier than '<'

            if !exists('g:airline_symbols')
                let g:airline_symbols = {}
            endif

            let g:airline_left_sep = '⮀'
            let g:airline_left_alt_sep = '⮁'
            let g:airline_right_sep = '⮂'
            let g:airline_right_alt_sep = '⮃'
            let g:airline_symbols.branch = '⭠'
            let g:airline_symbols.readonly = '⭤'
            let g:airline_symbols.linenr = '⭡'
        endif
    " }

    " gist-vim {
        let g:gist_detect_filetype = 1
        let g:gist_post_private = 1
        let g:gist_show_privates = 1
    " }

    " signify {
        let g:signify_vcs_list = [ 'git' ]
        let g:signify_line_highlight = 0
        let g:signify_sign_add = '+'
        let g:signify_sign_change = '!'
        let g:signify_sign_delete = '-'
        let g:signify_sign_delete_first_line = '-'
    " }

    " syntastic {
        let g:syntastic_ruby_checkers = [ 'mri', 'rubocop' ]
        let g:syntastic_python_checkers = [ 'pyflakes', 'python' ]
    " }

" }

" Functions {

    " UnBundle {
    function! UnBundle(arg, ...)
      let bundle = vundle#config#init_bundle(a:arg, a:000)
      call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
    endfunction

    com! -nargs=+         UnBundle
    \ call UnBundle(<args>)
    " }

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = { 'backup': 'backupdir', 'views': 'viewdir' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create " . settingname . ": " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

" }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }