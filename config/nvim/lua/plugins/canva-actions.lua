return {
  'canvanauts/mattpatterson-canva-actions.nvim',
  dependencies = {
    'nvimtools/none-ls.nvim',
    'stevearc/overseer.nvim',
    'folke/snacks.nvim',
  },
  build = 'pnpm install -g git+ssh://git@github.com/canvanauts/mattpatterson-tsimport-cli.git',
  opts = {},
}
