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
	let g:ctrlp_match_window = 'bottom,order:ttb'			" Order file matches top to bottom
	let g:ctrlp_switch_buffer = 0					" Always open files in new buffer
	let g:ctrlp_working_path_mode = 0				" Changes wkdir and CtrlP recognises change
	let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'	" Let CtrlP use Ag for searches
" }

" Deoplete provides autocomplete functionality {
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'Shougo/deoplete.nvim'
    Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }		" NodeJS autocomplete
    Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }	" GoLang autocomplete
" }
call plug#end()
