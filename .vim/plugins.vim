" Ensure vim-plug is installed and plugins loaded. {
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
" }

call plug#begin('~/.vim/plugged')
" Airline adds a funky status bar {
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'edkolev/tmuxline.vim'
	Plug 'bling/vim-bufferline'

	let g:airline_theme = 'badwolf'
	let g:airline_powerline_fonts = 1
	let g:airline_extensions#tabline#enabled = 1
" }

" Deoplete provides autocomplete functionality {
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    Plug 'Shougo/deoplete.nvim'
    Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }		" NodeJS autocomplete
    Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn global add tern' }	" GoLang autocomplete
" }
call plug#end()
