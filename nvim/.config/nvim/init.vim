set shiftwidth=4
set tabstop=4

" hybrid line numbers

set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" file chooser
let g:netrw_banner=0 " disable file finder annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1 " open splits to the right

" mouse mode
set mouse=a " enable mouse in all modes

"plugins
call plug#begin()

Plug 'chriskempson/base16-vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'jiangmiao/auto-pairs'

call plug#end()

" theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" fzf hotkey
nnoremap <C-p> :Files<CR>

" coc config:
" accept first completion on Enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" let g:deoplete#enable_at_startup = 1

