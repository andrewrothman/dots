set mouse=a " enable mouse in all modes
set lazyredraw
set updatetime=100
set clipboard+=unnamedplus " use system clipboard
set title " change title (useful for tmux <prefix>-w
set showcmd " show normal mode commands in bottom left
set nojoinspaces " single-spaces to separate sentences (formatting)
:let mapleader=" "

" config

:command Cfe :e $MYVIMRC
:command Cfs :source $MYVIMRC

" history

set history=1000 " remember more commands in history

" undo

set undolevels=1000 " remember more actions for undo
set undofile " persist undos to a file for use in subsequent sessions
nnoremap U <C-r> " redo... overrides a weird default

" centered cursor (almost always)

augroup VCenterCursor
	au!
	au BufEnter,WinEnter,WinNew,VimResized *,*.*
				\ let &scrolloff=winheight(win_getid())/2
augroup END

" hybrid line numbers

" todo: buffer exit and enter without lines (like in help docs) should be
" honored
set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" indent

set noexpandtab " use real tabs
set shiftwidth=4 " display tabs as 4 spaces
set tabstop=4 " shift indents by 4 spaces (tabs or spaces)
set linebreak " change wrapping
set breakindent " preserve wrapped indentation
set autoindent
set smartindent

" buffer search

set smartcase " case-insensitive unless a cap char is entered
set ignorecase " needed for smartcase
nnoremap <silent> <esc> :nohlsearch<CR> " clear with Escape

" moar search

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown({}))<cr>

lua << EOF
require('telescope').load_extension('fzy_native')
EOF

" open telescope on startup with empty buffer

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * if argc() == 0 | exe 'Telescope find_files theme=get_dropdown' | endif
augroup END

" saving

nnoremap <leader>s :wa<CR>

" splits

set splitbelow " horizontal split new buffers below
set splitright " vertical split new buffers to the right

" netrw

let g:netrw_banner=0 " disable file finder annoying banner
let g:netrw_altv=1 " open splits to the right

" just for now... to get used to no arrow keys

map <Up> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <Down> <Nop>

" cursor column guides

set cursorline
set colorcolumn=80,120

" git signs

set signcolumn=yes
let g:gitgutter_signs = 0
let g:gitgutter_highlight_linenrs = 1

" theme

set termguicolors

if filereadable(expand("~/.vimrc_background"))
	let base16colorspace=256
	source ~/.vimrc_background
endif

" so /usr/local/Cellar/neovim/HEAD-0496b57_1/share/nvim/runtime/syntax/hitest.vim
" https://www.reddit.com/r/neovim/comments/l00zzb/improve_style_of_builtin_lsp_diagnostic_messages/

function! s:base16_customize() abort
	" call Base16hi("Comment", "abd4bc", "", "", "", "", "") " cyan
	call Base16hi("Comment", "d4abc6", "", "", "", "", "") " pink
	call Base16hi("GitGutterAddLineNr", "7bad76", "252525", "", "", "", "")
	call Base16hi("GitGutterChangeLineNr", "9776ad", "252525", "", "", "", "")
	call Base16hi("GitGutterDeleteLineNr", "ad7976", "252525", "", "", "", "")
endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" statusline

function! StatuslineGit()
	let l:status = FugitiveStatusline()[5:-3]
	return strlen(l:status) > 0?'  '.l:status.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m
" todo: this would be cool... check the help, and maybe try it in lua?
" only want to show when available, with space before name, and with a good
" color
" set statusline+=%{nvim_treesitter#statusline()}
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %p%%
set statusline+=\ %l:%c

" autocomplete

set pumheight=15 " don't show me too much

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

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

" lsp

lua << EOF
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.tsserver.setup {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		require "lsp_signature".on_attach({
			bind = true, -- This is mandatory, otherwise border config won't get registered.
			handler_opts = {
				border = "single"
			}
		})
	end,
}

require'lspconfig'.efm.setup{
	filetypes = {
		"typescriptreact",
		"typescript"
	}
}
EOF

" lsp navigation
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" code actions
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

" treesitter

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

" set spell " turn on spell-check

" Easy window navigation
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" easy move lines

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" easily switch between buffers

" nnoremap <silent> H :bp<CR>
" nnoremap <silent> L :bn<CR>

" snippets

imap <expr> <C-Space>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-Space>'
smap <expr> <C-Space>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-Space>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" git commit messages

au FileType gitcommit setlocal textwidth=72
au FileType gitcommit setlocal colorcolumn=50,72
au FileType gitcommit setlocal spell

" trying <CR> as :

" " easy commands in normal mode
" noremap <CR> :

" " also remap <CR> as ':' in netrw (replace it with space)
" " augroup netrw_mapping
" "     autocmd!
" "     autocmd filetype netrw call NetrwMapping()
" " augroup END

" " function! NetrwMapping()
" " 	nmap <buffer> <Space> <Plug>NetrwLocalBrowseCheck
" "     nmap <buffer> <CR> :
" " endfunction

" autocmd User FugitiveIndex,FugitiveTag,FugitiveCommit,FugitiveTree,FugitiveBlob exe 'nnoremap <buffer> <Space> ' . maparg('<CR>', 'n')
" autocmd User FugitiveIndex,FugitiveTag,FugitiveCommit,FugitiveTree,FugitiveBlob nmap <buffer> <CR> :

lua << EOF
require("trouble").setup {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
	icons = false
}

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

telescope.setup {
	defaults = {
		mappings = {
			i = { ["<c-t>"] = trouble.open_with_trouble },
			n = { ["<c-t>"] = trouble.open_with_trouble },
		},
	},
}
EOF

nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>
