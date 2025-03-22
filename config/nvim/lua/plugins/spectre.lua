return {
  'nvim-pack/nvim-spectre',
  dependencies = 'nvim-lua/plenary.nvim',
  config = function()
    if vim.loop.os_uname().sysname == 'Darwin' then
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
    end
  end,
}
