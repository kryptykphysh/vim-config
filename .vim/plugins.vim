" Ensure vim-plug is installed and plugins loaded. {
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
" }

call plug#begin('~/.vim/plugged')

" Ack-Grep for searching in files {
	Plug 'mileszs/ack.vim'

	" Fallback to search with Ack if the Silver Searcher is not available
	if executable('ag')
		let g:ackprg = 'ag --vimgrep'
	endif
" }

" Airline adds a funky status bar {
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'edkolev/tmuxline.vim'
	Plug 'bling/vim-bufferline'

	let g:airline_theme = 'badwolf'
	let g:airline_powerline_fonts = 1
	let g:airline_extensions#tabline#enabled = 1
" }

" CtrlPVim for path searching {
	Plug 'ctrlpvim/ctrlp.vim'

	let g:ctrlp_map = '<c-p>'
	let g:ctrlp_cmd = 'CtrlP'
	let g:ctrlp_match_window = 'bottom,order:ttb'			            " Order file matches top to bottom
	let g:ctrlp_switch_buffer = 0					                    " Always open files in new buffer
	let g:ctrlp_working_path_mode = 0				                    " Changes wkdir and CtrlP recognises change
	let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'	    " Let CtrlP use Ag for searches
" }

" Deoplete provides autocomplete functionality {
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'Shougo/deoplete.nvim'
    let g:deoplete#enable_at_startup = 1
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    " Plugin key-mappings.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    
    " SuperTab like snippets behavior.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    "imap <expr><TAB>
    " \ pumvisible() ? "\<C-n>" :
    " \ neosnippet#expandable_or_jumpable() ?
    " \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    
    " For conceal markers.
    if has('conceal')
      set conceallevel=2 concealcursor=niv
    endif

    Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }	" GoLang autocomplete
" }

" Emmet for HTML joy {
    Plug 'mattn/emmet-vim'
    " Redefine Emmet trigger from <C-y> to ,
    let g:user_emmet_leader_key = ','
" }

" Fugitive gives us all the Git goodness {
    Plug 'tpope/vim-fugitive'
" }

" GoLang Related {
    Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }		        " NodeJS autocomplete
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" }

" NERDTree directory display {
    Plug 'scrooloose/nerdtree'
    map <F2> :NERDTreeToggle<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }

call plug#end()
