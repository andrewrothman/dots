---@module 'lazy'
---@type LazySpec
return {
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  -- See `:help gitsigns` to understand what each configuration keys does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    ---@module 'gitsigns'
    'lewis6991/gitsigns.nvim',
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      signs = {
        add = { text = '+' }, ---@diagnostic disable-line: missing-fields
        change = { text = '~' }, ---@diagnostic disable-line: missing-fields
        delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
      },
    },
  },

  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
}
