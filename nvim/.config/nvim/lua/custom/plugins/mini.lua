local utils = require('custom.utils')

--  A collection of various small independent plugins/modules
vim.pack.add { utils.gh 'nvim-mini/mini.nvim' }
require('mini.notify').setup()
require('mini.completion').setup()

local files = require('mini.files')
files.setup()
local function toggle_files()
  if files.close() ~= nil then return end
  local path = vim.api.nvim_buf_get_name(0)
  files.open(vim.uv.fs_stat(path) and path or nil)
end
vim.keymap.set('n', '<leader>e', toggle_files, { desc = 'Toggle file [E]xplorer', silent = true })

local clue = require('mini.clue')
clue.setup {
  triggers = {
    { mode = { 'n', 'x' }, keys = '<leader>' },
    { mode = { 'n', 'x' }, keys = 'g' },
    { mode = { 'n', 'x' }, keys = 'z' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'n', keys = '<C-w>' },
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    { mode = 'i', keys = '<C-x>' },
  },
  clues = {
    clue.gen_clues.g(),
    clue.gen_clues.z(),
    clue.gen_clues.windows(),
    clue.gen_clues.square_brackets(),
    clue.gen_clues.marks(),
    clue.gen_clues.registers(),
    clue.gen_clues.builtin_completion(),
    { mode = { 'n', 'x' }, keys = '<leader>s', desc = '[S]earch' },
    { mode = 'n', keys = '<leader>t', desc = '[T]oggle' },
    { mode = { 'n', 'x' }, keys = '<leader>h', desc = 'Git [H]unk' },
    { mode = 'n', keys = 'gr', desc = 'LSP Actions' },
  },
  window = { delay = 0 },
}

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons`.
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup()

-- Simple and easy statusline.
--  You could remove this setup call if you don't like it,
--  and try some other statusline plugin
local statusline = require 'mini.statusline'
-- Set `use_icons` to true if you have a Nerd Font
statusline.setup { use_icons = vim.g.have_nerd_font }

-- You can configure sections in the statusline by overriding their
-- default behavior. For example, here we set the section for
-- cursor location to LINE:COLUMN
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function() return '%2l:%-2v' end

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_git = function() return '' end

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_diff = function() return '' end

---@diagnostic disable-next-line: duplicate-set-field
statusline.section_lsp = function() return '' end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
