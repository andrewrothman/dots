local utils = require('custom.utils')

vim.pack.add { utils.gh 'mfussenegger/nvim-lint' }

vim.pack.add {
  { src = utils.gh 'nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  utils.gh 'nvim-lua/plenary.nvim',
  utils.gh 'MunifTanjim/nui.nvim',
  utils.gh 'Crysthamus/nvim-file-operations',
}

vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        -- TODO: old, still needed?
        -- disable <space>, default is 'toggle_node' which is unnecessary and conflicts with leader
        -- ['<space>'] = 'none',

        ['\\'] = 'close_window',
      },
    },
  },
}

-- Enable file operations based on LSP (automatic rename).
require("nvim-file-operations").setup()

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
