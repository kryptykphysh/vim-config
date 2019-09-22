" Colours {
	syntax enable			" enable syntax processing
	colorscheme badwolf
	set termguicolors
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
" }
