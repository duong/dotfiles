return {
  'nvim-pack/nvim-spectre',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    require('spectre').setup {
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = {
            '-i',
            '',
            '-E',
          },
        },
      },
    }
  end,
}
