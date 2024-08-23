return {
  'catppuccin/nvim',
  lazy = false,
  priority = 1000,
  opts = {
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      dap = true,
      dap_ui = true,
    },
  },
  config = function(_, opts)
    vim.cmd.colorscheme 'catppuccin-macchiato'
    require('catppuccin').setup(opts)
  end,
}
