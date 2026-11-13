local pick = require('mini.pick')
local extra = require('mini.extra').pickers
pick.setup()

local function grep_word()
  local pattern = vim.fn.expand '<cword>'
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '\22' then
    pattern = table.concat(vim.fn.getregion(vim.fn.getpos 'v', vim.fn.getpos '.', { type = mode }), '\n')
    vim.cmd.normal { '\27', bang = true }
  end
  pick.builtin.grep { pattern = pattern, method = 'plain' }
end

local searches = {
  { '<leader>sh', pick.builtin.help, '[S]earch [H]elp' },
  { '<leader>sk', extra.keymaps, '[S]earch [K]eymaps' },
  { '<leader>sf', pick.builtin.files, '[S]earch [F]iles' },
  { '<leader>sw', grep_word, '[S]earch current [W]ord' },
  { '<leader>sg', pick.builtin.grep_live, '[S]earch by [G]rep' },
  { '<leader>sd', extra.diagnostic, '[S]earch [D]iagnostics' },
  { '<leader>sr', pick.builtin.resume, '[S]earch [R]esume' },
  { '<leader>s.', extra.oldfiles, '[S]earch Recent Files ("." for repeat)' },
  { '<leader>sc', extra.commands, '[S]earch [C]ommands' },
  { '<leader><leader>', pick.builtin.buffers, '[ ] Find existing buffers' },
  { '<leader>/', function() extra.buf_lines { scope = 'current' } end, '[/] Fuzzily search in current buffer' },
  { '<leader>s/', extra.buf_lines, '[S]earch [/] in Open Files' },
  { '<leader>sn', function()
    pick.builtin.cli({ command = { 'rg', '--files', '--follow' } }, {
      source = { cwd = vim.fn.stdpath 'config', name = 'Neovim files' },
    })
  end, '[S]earch [N]eovim files' },
}

for _, search in ipairs(searches) do
  vim.keymap.set('n', search[1], search[2], { desc = search[3] })
end
vim.keymap.set('v', '<leader>sw', grep_word, { desc = '[S]earch current [W]ord' })

vim.keymap.set('n', '<leader>ss', function()
  local items = vim.tbl_map(function(search) return { text = search[3], action = search[2] } end, searches)
  local chosen = pick.start { source = { items = items, name = 'Search pickers', choose = function() end } }
  if chosen then chosen.action() end
end, { desc = '[S]earch [S]elect picker' })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('mini-pick-lsp-attach', { clear = true }),
  callback = function(event)
    local mappings = {
      { 'grr', 'references', '[G]oto [R]eferences' },
      { 'gri', 'implementation', '[G]oto [I]mplementation' },
      { 'grd', 'definition', '[G]oto [D]efinition' },
      { 'gO', 'document_symbol', 'Open Document Symbols' },
      { 'gW', 'workspace_symbol_live', 'Open Workspace Symbols' },
      { 'grt', 'type_definition', '[G]oto [T]ype Definition' },
    }
    for _, mapping in ipairs(mappings) do
      vim.keymap.set('n', mapping[1], function() extra.lsp { scope = mapping[2] } end, {
        buffer = event.buf,
        desc = mapping[3],
      })
    end
  end,
})
