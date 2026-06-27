local utils = require('custom.utils')

-- Automatically detects and sets the indentation.
vim.pack.add { utils.gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
