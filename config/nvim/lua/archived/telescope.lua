local actions = require 'telescope.actions'

-- Fuzzy Finder (files, lsp, etc)
return {
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
  opts = {
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
  },
  config = function(_, opts)
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup(opts)

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
    vim.keymap.set('n', '<leader>fd', function()
      require('telescope.builtin').diagnostics { severity_bound = 0 }
    end, { desc = 'Search Diagnostics' })
    vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = 'Search Resume' })
  end,
}
