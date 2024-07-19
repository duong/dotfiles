return {
  'nvimdev/lspsaga.nvim', -- fancy popups and lsp niceties, goto definition and peek
  opts = {
    debug = false,
    show_server_name = true,
    border = 'rounded',
    devicon = true,
    lightbulb = {
      enable = true,
    },
    finder = {
      keys = {
        open = 'o',
        vsplit = 's',
        split = 'i',
        quit = 'q',
        scroll_down = '<C-f>',
        scroll_up = '<C-b>',
      },
    },
    definition = {
      quit = 'q',
    },
    code_action = {
      keys = {
        quit = 'q',
        exec = '<CR>',
      },
    },
    rename = {
      keys = {
        quit = '<C-c>',
        exec = '<CR>',
      },
    },
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
}
