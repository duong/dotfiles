return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = false,
      -- auto is a special theme. It will automatically load theme for your colorscheme.
      -- If there's no theme available for your colorscheme then it'll try it's best to generate one.
      theme = 'auto',
      component_separators = '|',
      section_separators = '',
    },
  },
}
