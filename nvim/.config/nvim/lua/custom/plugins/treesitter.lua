return {
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      local filetype_to_parser = {
        bash = 'bash',
        c = 'c',
        cpp = 'cpp',
        diff = 'diff',
        go = 'go',
        html = 'html',
        janet = 'janet_simple',
        lua = 'lua',
        luadoc = 'luadoc',
        markdown = 'markdown',
        markdown_inline = 'markdown_inline',
        python = 'python',
        query = 'query',
        rust = 'rust',
        tsx = 'tsx',
        typescript = 'typescript',
        vim = 'vim',
        vimdoc = 'vimdoc',
      }

      local parsers = {}
      local filetypes = {}
      for ft, parser in pairs(filetype_to_parser) do
        table.insert(filetypes, ft)
        table.insert(parsers, parser)
        if parser ~= ft then
          vim.treesitter.language.register(parser, ft)
        end
      end

      require('nvim-treesitter').install(parsers)

      vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
