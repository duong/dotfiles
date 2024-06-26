-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- fidget.nvim will soon be completely rewritten. Pin plugin legacy tag to avoid breaking changes.
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
      'nvimdev/lspsaga.nvim',
    },
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', lazy = true, opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '▁', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '▔', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        untracked = { hl = 'GitSignsUntracked', text = '┃', numhl = 'GitSignsUntrackedNr', linehl = 'GitSignsUntrackedLn' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Actions
        map('n', '<leader>gl', gs.toggle_current_line_blame)
        map('n', '<leader>gd', gs.diffthis)
        map('n', '<leader>gD', function()
          gs.diffthis '~'
        end)
      end,
    },
  },
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-macchiato'
    end,
  },
  {
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
  },

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   main = "ibl",
  --   opts = {},
  -- },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- {
  --   "mfussenegger/nvim-lint",
  --   config = function()
  --     -- Your config will go here
  --   end
  -- },
  -- Fuzzy Finder (files, lsp, etc)
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  -- { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    'nvimdev/lspsaga.nvim', -- fancy popups and lsp niceties, goto definition and peek
    config = function()
      require('lspsaga').setup {
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
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  'ggandor/leap.nvim',
  'rrethy/vim-illuminate',
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper',
        config = {
          -- header is overridden by week_header
          header = {
            '                    /  ___  \\ ',
            '                 /  /  _  \\  \\ ',
            '               /( /( /(_)\\ )\\ )\\ ',
            '              (  \\  \\ ___ /  /  )',
            '              (    \\ _____ /    )',
            '              /(               )\\ ',
            '             |  \\             /  |',
            '             |    \\ _______ /    |',
            '              \\    / \\   / \\    /',
            '              \\/    | |    \\/',
            '                 | | ',
            '                 | |',
            '                 | |',
          },
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'd',
            },
          },
        },
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        event_handlers = {

          {
            event = 'file_opened',
            handler = function()
              -- auto close
              -- vimc.cmd("Neotree close")
              -- OR
              require('neo-tree.command').execute { action = 'close' }
            end,
          },
        },
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        javascript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
      },
    },
  },
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.debug',
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make hybrid line numbers default
vim.wo.rnu = true
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Hide cmdline when not in use https://www.reddit.com/r/neovim/comments/xb0hs1/is_it_possible_to_hide_command_line_when_it_is/
vim.o.cmdheight = 0

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>uw', '<cmd>set wrap!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ut2', '<cmd>set shiftwidth=2 tabstop=2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ut4', '<cmd>set shiftwidth=4 tabstop=4<CR>', { noremap = true, silent = true })

-- Remap for dealing with autoformat
vim.api.nvim_set_keymap('n', '<leader>lf', '<cmd>Format<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lo', '<cmd>OrganizeImports<CR>', { noremap = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure indent-blankline ]]
-- require("ibl").setup()

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require 'telescope.actions'
require('telescope').setup {
  defaults = {
    path_display = { 'truncate' },
    sorting_strategy = 'ascending',
    layout_config = {
      horizontal = { prompt_position = 'top', preview_width = 0.55 },
      vertical = { mirror = false },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    mappings = {
      i = {
        ['<C-n>'] = actions.cycle_history_next,
        ['<C-p>'] = actions.cycle_history_prev,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<Tab>'] = actions.move_selection_next,
        ['<S-Tab>'] = actions.move_selection_previous,
        ['<C-h>'] = actions.select_horizontal,
        ['<C-x>'] = actions.delete_buffer,
      },
      n = { q = actions.close },
    },
  },
}

-- [[ Configure leap ]]
require('leap').add_default_mappings()

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = 'Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>fF', function()
  require('telescope.builtin').find_files { hidden = true }
end, { desc = 'Search Files (Hidden)' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = 'Search current word' })
vim.keymap.set('n', '<leader>fW', function()
  require('telescope.builtin').grep_string { additional_args = { '--hidden' } }
end, { desc = 'Search current word (Hidden)' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>fG', function()
  require('telescope.builtin').live_grep { additional_args = { '--hidden' } }
end, { desc = 'Search by Grep (Hidden)' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = 'Search Resume' })

-- [[ Configure Neotree ]]
vim.keymap.set('n', '<C-b>', '<Cmd>Neotree toggle reveal_force_cwd<CR>')

-- [[ Configure Noice ]]
vim.keymap.set('n', '<leader>nd', function()
  require('noice').cmd 'dismiss'
end)
vim.keymap.set('n', '<leader>nf', function()
  require('noice').cmd 'telescope'
end)
vim.keymap.set('n', '<leader>nl', function()
  require('noice').cmd 'last'
end)
vim.keymap.set('n', '<leader>nh', function()
  require('noice').cmd 'history'
end)

-- [[ Configure toggleterm ]]
require('toggleterm').setup {}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })

-- [[ Configure Comment ]]
require('ts_context_commentstring').setup {
  enable_autocmd = false,
}
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'c_sharp' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<cr>', { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>ld', '<cmd>Lspsaga show_line_diagnostics<CR>', { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure conform.nvim ]]
require('conform').setup {
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lr', '<cmd>Lspsaga rename<cr>', 'Rename')
  nmap('<leader>la', '<cmd>Lspsaga code_action<cr>', 'LSP Actions')

  nmap('gd', '<cmd>Lspsaga goto_definition<cr>', 'Goto Definition')
  nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
  nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
  nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Symbols')
  nmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

  -- See `:help K` for why this keymap
  nmap('K', '<cmd>Lspsaga hover_doc<cr>', 'Hover Documentation')
  nmap('<C-k>', '<cmd>Lspsaga peek_definition<cr>', 'Peek definition')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace List Folders')

  -- Create a command `:OrganizeImports` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'OrganizeImports', function(_)
    vim.lsp.buf.execute_command {
      command = '_typescript.organizeImports',
      arguments = { vim.api.nvim_buf_get_name(0) },
    }
  end, { desc = 'Organize current buffer imports with LSP' })

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = 'Code', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = 'Document', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = 'LSP options', _ = 'which_key_ignore' },
  ['<leader>u'] = { name = 'UI', _ = 'which_key_ignore' },
  ['<leader>uw'] = { name = 'Toggle word wrap', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = 'Git options', _ = 'which_key_ignore' },
  ['<leader>gg'] = { name = 'Toggle lazygit', _ = 'which_key_ignore' },
  ['<leader>gl'] = { name = 'Toggle git line blame', _ = 'which_key_ignore' },
  ['<leader>gd'] = { name = 'View git diff', _ = 'which_key_ignore' },
  ['<leader>gD'] = { name = 'View git Diff (?) ', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = 'Rename', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = 'Workspace', _ = 'which_key_ignore' },
  ['<leader>lf'] = { name = 'Format buffer', _ = 'which_key_ignore' },
  ['<leader>lo'] = { name = 'Organize Imports', _ = 'which_key_ignore' },
  ['<leader>n'] = { name = 'Noice', _ = 'which_key_ignore' },
  ['<leader>nd'] = { name = 'Notification dismiss', _ = 'which_key_ignore' },
  ['<leader>nf'] = { name = 'Notification find', _ = 'which_key_ignore' },
  ['<leader>nl'] = { name = 'Notification last', _ = 'which_key_ignore' },
  ['<leader>nh'] = { name = 'Notification history', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = 'Search', _ = 'which_key_ignore' },
}

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  tsserver = {
    completions = {
      completeFunctionCalls = true,
    },
    javascript = {
      format = {
        semicolons = 'insert',
      },
    },
    typescript = {
      format = {
        semicolons = 'insert',
      },
    },
  },
  csharp_ls = {},

  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure capabilities for folding
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `tsserver`:
  -- ["tsserver"] = function()
  --   require("lspconfig").tsserver.setup {
  --     handlers = {
  --       ["textDocument/publishDiagnostics"] = function() end,
  --     },
  --   }
  -- end
}

-- Configure lspconfig for folding with nvim-ufo
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zm', require('ufo').closeAllFolds, { desc = 'Close all folds' })
vim.keymap.set('n', 'zK', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = 'Peek Fold' })

require('ufo').setup {
  provider_selector = function()
    return { 'lsp', 'indent' }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

local border_opts = {
  border = 'rounded',
  winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None',
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(border_opts),
    documentation = cmp.config.window.bordered(border_opts),
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- [[ Configure catppuccin ]]
require('catppuccin').setup {
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
  },
}

-- [[ Configure noice ]]
require('noice').setup {
  cmdline = {
    format = {
      conceal = false,
      cmdline = { pattern = '^:', icon = '：', lang = 'vim' },
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = '42%',
        col = '50%',
      },
      size = {
        width = 60,
        height = 'auto',
      },
    },
    popupmenu = {
      relative = 'editor',
      position = {
        row = '60%',
        col = '50%',
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = 'rounded',
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
      },
    },
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}

-- [[ Configure null_ls ]]
require('mason').setup()
local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.csharpier,
  },
}
require('mason-null-ls').setup {
  ensure_installed = { 'eslint_d', 'stylua', 'prettierd', 'csharpier' },
  automatic_installation = true,
}

-- [[ Configure nvim-spectre ]]
vim.keymap.set('n', '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})

-- [[ Configure nvim-lint ]] https://www.reddit.com/r/neovim/comments/15pj1oi/using_nvimlint_as_a_nullls_alternative_for_linters/
-- local lint = require("lint")
-- lint.linters_by_ft = {
--   javascript = {
--     "eslint_d"
--   },
--   typescript = {
--     "eslint_d"
--   },
--   javascriptreact = {
--     "eslint_d"
--   },
--   typescriptreact = {
--     "eslint_d"
--   }
-- }

-- vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
--   callback = function()
--     -- Disable virtual_text for eslint_d
--     local ns = require("lint").get_namespace("eslint_d")
--     vim.diagnostic.config({ virtual_text = false }, ns)
--
--     -- Enable linting
--     local lint_status, lint = pcall(require, "lint")
--     if lint_status then
--       lint.try_lint()
--     end
--   end,
-- })

-- Disable all virtual text lsp + lint
-- vim.diagnostic.config({ virtual_text = false })

-- disable all lsp virtual_text
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = false
--   }
-- )

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
