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

-- Highlight entire line for errors
-- Highlight the line number for warnings
-- local signs = { Error = '⊗ ', Warn = '', Hint = '⍰', Info = ' ' }
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    },
  },
}

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

-- https://github.com/nvimdev/lspsaga.nvim/issues/1520 fixes broken show floating diagnostic
vim.diagnostic.config {
  severity_sort = true,
}

-- Amp terminal navigation
vim.keymap.set('n', '<C-\\>', '<cmd>AmpTerminal<CR>', { desc = 'Toggle Amp terminal' })
vim.keymap.set('t', '<C-\\>', '<C-\\><C-n><C-w>p', { desc = 'Jump from Amp terminal to previous window' })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', { desc = 'Move to left pane from terminal' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', { desc = 'Move to right pane from terminal' })

