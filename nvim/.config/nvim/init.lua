--[[

Neovim config based on kickstart.nvim:
https://github.com/nvim-lua/kickstart.nvim

Neovim help:
  - :help
  - <leader>sh - search help
  - :checkhealth

Lua help:
  - https://learnxinyminutes.com/docs/lua/
  - :help lua-guide
  - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Up-to-date as of kickstart.nvim commit SHA:
748f67f49dd9fed47686d1d15e8566d2cba8ed35

--]]

require("custom.options")
require("custom.keymaps")
require("custom.autocommands")

do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()

  -- Update Treesitter parsers after the plugin is installed or updated.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

require("custom.plugins.guess-indent")
require("custom.plugins.git")
require("custom.plugins.which-key")
require("custom.plugins.mini")
require("custom.plugins.pick")
require("custom.plugins.lsp")
require("custom.plugins.format")
require("custom.plugins.autocomplete")
require("custom.plugins.treesitter")
require("custom.plugins.lint")

require("custom.commands.edit-config")
require("custom.commands.yank-path")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
