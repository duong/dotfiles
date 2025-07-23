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
      { '<leader>l', desc = 'LSP options' },
      { '<leader>u', group = 'UI' },
      { '<leader>uw', '<cmd>set wrap!<CR>', desc = 'Toggle word wrap' },

      -- Markdown Preview
      { '<leader>um', group = 'Markdown' },
      { '<leader>ump', '<cmd>MarkdownPreview<CR>', desc = 'Open Markdown Preview' },
      { '<leader>ums', '<cmd>MarkdownPreviewStop<CR>', desc = 'Stop Markdown Preview' },
      { '<leader>umm', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Toggle Markdown Preview' },

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
      { '<leader>lf', '<cmd>Format<CR>', desc = 'Format buffer' },
      { '<leader>lo', '<cmd>OrganizeImports<CR>', desc = 'Organize Imports' },
      { '<leader>lW', '<cmd>noa w<CR>', desc = 'Write without formatting' },

      -- Debugger
      {
        mode = { 'n' },
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        { '<leader>d', group = 'Debugger' },
        { '<leader>dd', '<cmd>DapToggleRepl<CR>', desc = 'Debug: Toggle UI' },
        { '<leader>db', '<cmd>DapToggleBreakpoint<CR>', desc = 'Debug: Toggle Breakpoint' },
        { '<leader>dc', '<cmd>DapContinue<CR>', desc = 'Debug: Start/Continue' },
        { '<leader>di', '<cmd>DapStepInto<CR>', desc = 'Debug: Step Into' },
        { '<leader>dv', '<cmd>DapStepOver<CR>', desc = 'Debug: Step Over' },
        { '<leader>do', '<cmd>DapStepOut<CR>', desc = 'Debug: Step Out' },
        { '<leader>dt', '<cmd>DapTerminate<CR>', desc = 'Debug: Terminate' },
      },

      -- Dadbod (database)
      {
        mode = { 'n' },
        { '<leader>b', group = 'Database' },
        { '<leader>bb', '<cmd>DBUIToggle<CR>', desc = 'Toggle UI' },
        { '<leader>ba', '<cmd>DBUIAddConnection<CR>', desc = 'Add Connection' },
        { '<leader>bf', '<cmd>DBUIFindBuffer<CR>', desc = 'Find Buffer' },
        { '<leader>bd', '<cmd>DbProjectDelete<CR>', desc = 'Project Delete' },
      },

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
        mode = { 'n', 'v' },
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
      { '<leader>uf', '<cmd>CopyRelativePath<CR>', desc = 'Copy Relative Filepath to Clipboard' },
      { '<leader>uF', '<cmd>CopyFullPath<CR>', desc = 'Copy Full Filepath to Clipboard' },

      -- Move between splits
      { '<C-h>', '<Cmd>wincmd h<CR>', mode = 'n' },
      { '<C-j>', '<Cmd>wincmd j<CR>', mode = 'n' },
      { '<C-k>', '<Cmd>wincmd k<CR>', mode = 'n' },
      { '<C-l>', '<Cmd>wincmd l<CR>', mode = 'n' },
    }
  end,
}
