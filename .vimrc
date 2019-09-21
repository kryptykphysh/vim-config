" Colours {
	syntax enable			" enable syntax processing
	colorscheme badwolf
	set termguicolors
" }

source ./.vim/plugins.vim		" Load vim-plug and plugins

" Airline taskbar configuration {
	let g:airline_theme = 'badwolf'
	let g:airline_powerline_fonts = 1
	let g:airline_extensions#tabline#enabled = 1
" }
