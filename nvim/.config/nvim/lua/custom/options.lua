-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- see `:help vim.o`, `:help option-list`

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false -- already in statusline

-- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300 -- displays which-key popup sooner
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true -- see `:help 'list'`
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- see `:help 'listchars'`

vim.o.inccommand = 'split' -- previous substitutions as you type
vim.o.cursorline = true
-- vim.o.scrolloff = 10
vim.o.confirm = true -- prompt instead of failing commands due to unsaved changes

vim.o.hlsearch = false
vim.o.ts = 2
vim.o.sts = 2
vim.o.sw = 2
vim.o.textwidth = 120

vim.o.title = true
