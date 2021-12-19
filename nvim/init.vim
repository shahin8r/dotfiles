call plug#begin('~/.vim/plugged')
  Plug 'nanotech/jellybeans.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-rhubarb'
  Plug 'pantharshit00/vim-prisma'
call plug#end()

let g:netrw_liststyle = 3
let g:netrw_dirhistmax = 0
let g:coc_global_extensions = ['coc-tsserver', 'coc-angular', 'coc-prettier', 'coc-phpls', 'coc-php-cs-fixer', 'coc-prisma']
source $HOME/.config/nvim/coc.vim

set background=dark
set syntax
set nu rnu
set updatetime=100
set scrolloff=10
set autoread
set autoindent 
set expandtab
set shiftwidth=2
set tabstop=2
set signcolumn=auto
set cmdheight=1
set noswapfile
set nowrap
set hidden
set termguicolors

colorscheme jellybeans

hi Normal guibg=none
hi SignColumn guibg=none
hi LineNr guibg=none
hi CursorLineNr guibg=none guifg=#666666
hi GitGutterAdd guibg=none
hi GitGutterChange guibg=none
hi GitGutterDelete guibg=none
hi GitGutterChangeDelete guibg=none
hi TabLine guibg=none guifg=#666666
hi TabLineSel guibg=none guifg=#ffffff
hi NonText guibg=none guifg=#666666
hi StatusLine guibg=#222222 guifg=#cccccc
hi StatusLineNc guibg=#111111 guifg=#666666
hi VertSplit guibg=none guifg=#222222

imap jj <Esc>
let mapleader=","
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <Leader>c :nohl<CR>
nnoremap <Leader>tt :tab split<CR>
nnoremap <Leader>gcc :Commits<CR>
nnoremap <Leader>gcf :BCommits<CR>

set statusline=\ %{pathshorten(expand('%:f'))}
set statusline+=\ %(\[%{fugitive#head()}]%)
set statusline+=\ %m%r%y%w%=C:\%c\ L:\%l\/\%L\ 

autocmd BufWritePost *.php silent! call CocCommand php-cs-fixer.fix

