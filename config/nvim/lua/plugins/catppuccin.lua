return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-macchiato'
  end,
  opts = {
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
    },
  },
}
