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
" let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1 " open splits to the right

" mouse mode
set mouse=a " enable mouse in all modes

" use system clipboard
set clipboard+=unnamedplus

" plugins
call plug#begin()

Plug 'chriskempson/base16-vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'ojroques/nvim-lspfuzzy'

Plug 'neovim/nvim-lsp'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'christoomey/vim-tmux-runner'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'tpope/vim-commentary'

Plug 'editorconfig/editorconfig-vim'
Plug 'szw/vim-g'
Plug 'vimwiki/vimwiki'

Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'

call plug#end()

lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.tsserver.setup { capabilities = capabilities }
require'lspconfig'.efm.setup{ filetypes = { "typescriptreact" } }
EOF

lua << EOF
vim.o.completeopt = "menuone,noselect,preview"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
	vsnip = true;
	emoji = true;
  };
}
EOF

lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { "typescript", "tsx" },
	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		init_selection = "gnn", -- not working... in vis mode start incremental selection
		node_incremental = "grn", -- in vis mode, increment selection to upper named parent
		scope_incremental = "grc", -- in vis mode, increment selection to upper scopee
		node_decremental = "grm", -- in vis mode, decrement selection to previous named node
	},
	context_commentstring = { enable = true },
}
EOF

lua require('gitsigns').setup()

" lua require('lspfuzzy').setup {}

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

set updatetime=300
" set hidden " switch buffers without saving or undoing
" set copyindent " copy the previous indentation on autoindenting
set cursorline
set lazyredraw " buffer renders
set title " change title (useful for tmux <prefix>-w
set linebreak " change wrapping
set breakindent " preserve wrapped indentation
set noshowcmd " don't show the command while typing (like in normal mode)
set history=1000 " remember more commands in history
set undolevels=1000 " remember more actions for undo
set undofile " persist undos to a file for use in subsequent sessions
set pumheight=30
" set foldmethod=indent " this one might be nice to toggle on when reading unfamiliar code
" set spell " turn on spell-check
set colorcolumn=80,120

" just for now... to get used to no arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Easy window navigation
" conflicts with snippets mappings
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" i'm not sure if this will break things, but would be helpful for line wrapping
" nnoremap j gj
" nnoremap k gk

:command RcEdit :e $MYVIMRC
:command RcSource :source $MYVIMRC

:let mapleader=","
autocmd FileType typescript,typescriptreact,javascript,javascriptreact noremap <leader>r :VtrSendCommandToRunner! y start<CR>
nnoremap <leader>q :VtrKillRunner<CR>
" let g:VtrUseVtrMaps = 1
let g:VtrPercentage = 10
nnoremap <leader>g :Google\ 
vnoremap <leader>g :Google\ 
nnoremap <leader>e :Ex<CR>
nnoremap <leader>E :Ex .<CR>

" easy commands in normal mode
noremap <CR> :

" also remap <CR> as ':' in netrw (replace it with space)
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
	nmap <buffer> <Space> <Plug>NetrwLocalBrowseCheck
    nmap <buffer> <CR> :
endfunction

" easy indent shift
nnoremap <leader>] >>
nnoremap <leader>[ <<
vnoremap <leader>] >gv 
vnoremap <leader>[ <gv

" easy move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap U <C-r> " by default, this command is like undo for the exact line you're on, with some caveats... i don't think it's too useful

" almost always keep cursor centered
augroup VCenterCursor
  au!
  au BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ let &scrolloff=winheight(win_getid())/2
augroup END

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" lsp bindings
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" auto-expanding
inoremap (; (<CR>);<C-c>O
inoremap (, (<CR>),<C-c>O
inoremap {; {<CR>};<C-c>O
inoremap {, {<CR>},<C-c>O
inoremap [; [<CR>];<C-c>O
inoremap [, [<CR>],<C-c>O

" easily switch between buffers
" nnoremap <silent> H :bp<CR>
" nnoremap <silent> L :bn<CR>

" navigate differently
" noremap <CR>	mz<C-B>
" noremap <Space>	mz<C-F>
" noremap <Tab>	`zzz

" move within wrapped lines
" nnoremap j gj
" nnoremap k gk

" easily yank entire lines
" nmap Y y$

" snippets

"   Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

"   Expand or jump
imap <expr> <leader>.   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <leader>.  vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

"   Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

"   Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
"   See https://github.com/hrsh7th/vim-vsnip/pull/50
"   note: messes with Substitute in normal mode (S)
" nmap        s   <Plug>(vsnip-select-text)
" xmap        s   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        S   <Plug>(vsnip-cut-text)

" theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set termguicolors

function! s:base16_customize() abort
	" call Base16hi("Comment", "11f0c3", "ff00ff", "", "", "", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" so /usr/local/Cellar/neovim/HEAD-0496b57_1/share/nvim/runtime/syntax/hitest.vim
" https://www.reddit.com/r/neovim/comments/l00zzb/improve_style_of_builtin_lsp_diagnostic_messages/
call Base16hi("Comment", "abd4bc", "", "", "", "", "")
call Base16hi("GitSignsAdd", "7ed67e", "", "", "", "", "")
call Base16hi("GitSignsDelete", "d67e86", "", "", "", "", "")
call Base16hi("GitSignsChange", "a17ed6", "", "", "", "", "")
call Base16hi("LspDiagnosticsVirtualTextHint", "FFFFFF", "", "", "", "", "")
call Base16hi("LspDiagnosticsVirtualTextError", "FF0000", "", "", "", "", "")
call Base16hi("LspDiagnosticsVirtualTextWarning", "FFFF00", "", "", "", "", "")

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fw :Windows<CR>
nnoremap <leader>fb :Buffers<CR>
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }

" splits
set splitbelow " horizontal split new buffers below
set splitright " vertical split new buffers to the right

let g:vimwiki_list = [{'path': '~/Documents/Brain', 'syntax': 'markdown', 'ext': '.md'}]
:call vimwiki#vars#init()

