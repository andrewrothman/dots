--[[

NeoVim help:
  - :help
  - <leader>sh - search help
  - :checkhealth

Lua help:
  - https://learnxinyminutes.com/docs/lua/
  - :help lua-guide
  - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Up-to-date as of kickstart.nvim commit 6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6

--]]

require("custom.options")
require("custom.keymaps")
require("custom.autocommands")

require("custom.commands.edit-config")
require("custom.commands.yank-path")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- see ":Lazy" and ":Lazy update"
require('lazy').setup {
  -- NOTE: Plugins can be added via a link or github org/name. To run setup automatically, use `opts = {}`

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },

  -- TODO: try:
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search

  -- {
  --   -- Set lualine as statusline
  --   'nvim-lualine/lualine.nvim',
  --   -- See `:help lualine.txt`
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       theme = 'onedark',
  --       component_separators = '|',
  --       section_separators = '',
  --     },
  --     sections = { lualine_c = { { 'filename', path = 3 } } },
  --   },
  -- },

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   opts = {
  --     char = '┊',
  --     show_trailing_blankline_indent = false,
  --   },
  -- },
}

-- Remap for dealing with word wrap
-- vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.cmd [[
  augroup tsc\_comp
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc\ --noEmit\ --pretty\ false
  augroup END
]]

-- NOTE: AJR old:
-- let g:netrw_banner=0 " disable file finder annoying banner
-- let g:netrw_altv=1 " open splits to the right
-- nnoremap <leader>s :wa<CR>
-- set cursorline
-- set colorcolumn=80,120
-- set linebreak
-- set pumheight=15 " don't show me too much
-- set spell " turn on spell-check
-- vnoremap J :m '>+1<CR>gv=gv
-- vnoremap K :m '<-2<CR>gv=gv
-- nnoremap <silent> H :bp<CR>
-- nnoremap <silent> L :bn<CR>
-- set history=1000 " remember more commands in history
-- set undolevels=1000 " remember more actions for undo
-- nnoremap U <C-r>
-- au FileType gitcommit setlocal textwidth=72
-- au FileType gitcommit setlocal colorcolumn=50,72
-- au FileType gitcommit setlocal spell

-- " open telescope on startup with empty buffer
-- augroup ProjectDrawer
--     autocmd!
--     autocmd VimEnter * if argc() == 0 | exe 'Telescope find_files theme=get_dropdown' | endif
-- augroup END

-- " todo: buffer exit and enter without lines (like in help docs) should be
-- " honored
-- set number relativenumber
-- :augroup numbertoggle
-- :  autocmd!
-- :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
-- :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
-- :augroup END

-- function! s:base16_customize() abort
-- 	" call Base16hi("Comment", "abd4bc", "", "", "", "", "") " cyan
-- 	call Base16hi("Comment", "d4abc6", "", "", "", "", "") " pink
-- 	call Base16hi("GitSignsAdd", "7bad76", "252525", "", "", "", "")
-- 	call Base16hi("GitSignsChange", "9776ad", "252525", "", "", "", "")
-- 	call Base16hi("GitSignsDelete", "ad7976", "252525", "", "", "", "")
-- endfunction

-- function! StatuslineGit()
-- 	let l:status = FugitiveStatusline()[5:-3]
-- 	return strlen(l:status) > 0?'  '.l:status.' ':''
-- endfunction
--
-- set statusline=
-- set statusline+=%#PmenuSel#
-- set statusline+=%{StatuslineGit()}
-- set statusline+=%#LineNr#
-- set statusline+=\ %f
-- set statusline+=%m
-- " todo: this would be cool... check the help, and maybe try it in lua?
-- " only want to show when available, with space before name, and with a good
-- " color
-- " set statusline+=%{nvim_treesitter#statusline()}
-- set statusline+=%=
-- set statusline+=%#CursorColumn#
-- set statusline+=\ %p%%
-- set statusline+=\ %l:%c

-- nacro90/numb.nvim

-- TODO: lock lazy deps in dotfiles repo, like this - https://github.com/nvim-lua/kickstart.nvim/commit/5740ddcf9c89c616b114e0b6c39ac66f857d609b
-- TODO: refactor telescope - https://github.com/nvim-lua/kickstart.nvim/commit/e87b7281ed19a49d528dec16dc0967616c1dc045
-- TODO: https://github.com/nvim-lua/kickstart.nvim/commit/8c6b78c770e34f8b9cb028633403b85010f28d7e
-- TODO: https://github.com/nvim-lua/kickstart.nvim/commit/7e54a4c5c80ccefa993777accbce97a20f5348cc
-- TODO: https://github.com/nvim-lua/kickstart.nvim/commit/e79572c9e6978787af2bca164a85ab6821caeb7b

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
