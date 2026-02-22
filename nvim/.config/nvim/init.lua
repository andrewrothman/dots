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
}

-- TODO: try nacro90/numb.nvim
-- TODO: lock lazy deps in dotfiles repo, like this - https://github.com/nvim-lua/kickstart.nvim/commit/5740ddcf9c89c616b114e0b6c39ac66f857d609b
-- TODO: https://github.com/nvim-lua/kickstart.nvim/commit/7e54a4c5c80ccefa993777accbce97a20f5348cc
-- TODO: https://github.com/nvim-lua/kickstart.nvim/commit/e79572c9e6978787af2bca164a85ab6821caeb7b

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
