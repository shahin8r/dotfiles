call plug#begin('~/.vim/plugged')
  Plug 'flazz/vim-colorschemes'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'leafgarland/typescript-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-rhubarb'
  Plug 'ryanoasis/vim-devicons'
  Plug 'pantharshit00/vim-prisma'
call plug#end()

let g:coc_global_extensions = ['coc-tsserver', 'coc-angular', 'coc-prettier', 'coc-phpls', 'coc-php-cs-fixer', 'coc-prisma']
source $HOME/.config/nvim/coc.vim

set background=dark
set syntax
set number relativenumber
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

colorscheme jellybeans

hi Normal ctermbg=black
hi SignColumn ctermbg=black
hi LineNr ctermbg=black
hi CursorLineNr ctermbg=black ctermfg=59
hi GitGutterAdd ctermbg=black
hi GitGutterChange ctermbg=black
hi GitGutterDelete ctermbg=black
hi GitGutterChangeDelete ctermbg=black
hi Whitespace ctermbg=black ctermfg=59
hi TabLine ctermbg=black ctermfg=59
hi TabLineSel ctermbg=black ctermfg=255
hi NonText ctermbg=black ctermfg=59

imap jj <Esc>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <Leader>c :nohl<CR>
nnoremap <Leader>tt :tab split<CR>

set listchars=space:·

let g:airline_powerline_fonts = 2

autocmd BufWritePost *.php silent! call CocCommand php-cs-fixer.fix

