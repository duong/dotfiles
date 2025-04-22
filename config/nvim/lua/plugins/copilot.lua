return {
  'github/copilot.vim',
  event = 'InsertEnter',
  config = function()
    -- Disable Tab key mapping to prevent conflicts
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap('i', '<C-L>', 'copilot#Accept("<CR>")', { expr = true, silent = true })

    -- Enable Copilot for specific file types
    vim.g.copilot_filetypes = {
      ['*'] = true,
      -- python = true,
      -- javascript = true,
      -- typescript = true,
      -- lua = true,
    }
  end,
}
