-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  lazy = false,
  opts = {
    preset = 'modern',
  },
  config = function(_, opts)
    -- document existing key chains
    require('which-key').setup(opts)
    local wk = require 'which-key'
    wk.add {
      { '<leader>c', desc = 'Code' },
      { '<leader>d', desc = 'Document' },
      { '<leader>l', desc = 'LSP options' },
      { '<leader>u', group = 'UI' },
      { '<leader>uw', '<cmd>set wrap!<CR>', desc = 'Toggle word wrap' },

      -- Git options
      { '<leader>g', group = 'Git options' },
      { '<leader>gg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', desc = 'Toggle lazygit' },
      { '<leader>gl', desc = 'Toggle git line blame' },
      { '<leader>gd', desc = 'View git diff' },
      { '<leader>gD', desc = 'View git Diff (?) ' },

      { '<leader>h', desc = 'More git' },
      { '<leader>r', desc = 'Rename' },
      { '<leader>f', desc = 'Find' },
      { '<leader>w', desc = 'Workspace' },
      { '<leader>lf', vim.lsp.buf.format, desc = 'Format buffer' },
      { '<leader>lo', '<cmd>OrganizeImports<CR>', desc = 'Organize Imports' },

      -- Noice
      { '<leader>n', desc = 'Noice' },
      {
        '<leader>nd',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = 'Notification dismiss',
      },
      {
        '<leader>nf',
        function()
          require('noice').cmd 'telescope'
        end,
        desc = 'Notification find',
      },
      {
        '<leader>nl',
        function()
          require('noice').cmd 'last'
        end,
        desc = 'Notification last',
      },
      {
        '<leader>nh',
        function()
          require('noice').cmd 'history'
        end,
        desc = 'Notification history',
      },

      -- Spectre search
      { '<leader>s', desc = 'Search' },
      {
        mode = { 'n' },
        { '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>', desc = 'Toggle Spectre' },
        { '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = 'Search current word' },
        { '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = 'Search on current file' },
      },
      { '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = 'Search current word', mode = 'n' },
      { '<C-b>', '<Cmd>Neotree toggle reveal_force_cwd<CR>', mode = 'n' },

      -- Diagnostic keymaps
      {
        mode = { 'n' },
        { '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', desc = 'Go to previous diagnostic message' },
        { ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', desc = 'Go to next diagnostic message' },
        { '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', desc = 'Open floating diagnostic message' },
        { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostics list' },
      },

      -- UI stuff
      { '<leader>ut', desc = 'Set spaces' },
      { '<leader>ut2', '<cmd>set shiftwidth=2 tabstop=2<CR>', desc = 'Set spaces 2' },
      { '<leader>ut4', '<cmd>set shiftwidth=4 tabstop=4<CR>', desc = 'Set spaces 4' },
      { '<leader>ur', '<cmd>set rnu!<CR>', desc = 'Toggle relative line numbers' },
    }
  end,
}
