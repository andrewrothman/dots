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
f0a2108ed51547793c758d9318bad94f242b22e5

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

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

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
require("custom.plugins.telescope")
require("custom.plugins.lsp")
require("custom.plugins.format")
require("custom.plugins.autocomplete")
require("custom.plugins.treesitter")
require("custom.plugins.lint")
require("custom.plugins.neo-tree")

require("custom.commands.edit-config")
require("custom.commands.yank-path")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
