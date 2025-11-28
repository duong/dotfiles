if vim.env.PROF then
  -- example for lazy.nvim
  -- change this to the correct path for your plugin manager
  local snacks = vim.fn.stdpath 'data' .. '/lazy/snacks.nvim'
  vim.opt.rtp:append(snacks)
  require('snacks.profiler').startup {
    startup = {
      event = 'VimEnter', -- stop profiler on this event. Defaults to `VimEnter`
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  }
end

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager - https://lazy.folke.io/installation
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup {
  spec = {
    -- import all plugins from ./lua/plugins/*.lua
    { import = 'plugins' },

    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        { 'mason-org/mason.nvim', config = true },
        { 'mason-org/mason-lspconfig.nvim' },

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        -- fidget.nvim will soon be completely rewritten. Pin plugin legacy tag to avoid breaking changes.
        { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/lazydev.nvim',
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

        -- tailwind
        'onsails/lspkind-nvim',
        'tailwind-tools',
      },
    },
    {
      'jay-babu/mason-null-ls.nvim',
      event = { 'BufReadPre', 'BufNewFile' },
      dependencies = {
        'mason-org/mason.nvim',
        'nvimtools/none-ls.nvim',
        'nvimtools/none-ls-extras.nvim',
      },
    },
    -- Since the official netcoredbg repo has no native macOS arm64 build
    {
      'Cliffback/netcoredbg-macOS-arm64.nvim',
      dependencies = { 'mfussenegger/nvim-dap' },
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { 'catppuccin-macchiato' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
}

require 'config'
require 'commands.highlight-yank'

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
-- NOTE: Remember that lua is a real programming language, and as such it is possible
-- to define small helper and utility functions so you don't have to repeat yourself
-- many times.
--
-- In this case, we create a function that lets us more easily define mappings specific
-- for LSP related items. It sets the mode, buffer and description for us each time.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lr', '<cmd>Lspsaga rename<cr>', 'Rename')
  nmap('<leader>la', '<cmd>Lspsaga code_action<cr>', 'LSP Actions')

  -- nmap('gd', '<cmd>Lspsaga goto_definition<cr>', 'Goto Definition')
  -- nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
  -- nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
  -- nmap('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Symbols')
  -- nmap('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

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
end

-- Setup neovim lua configuration
require('lazydev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure capabilities for folding
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- Setup organize imports
-- https://www.reddit.com/r/neovim/comments/1azofv9/how_to_organize_imports_on_save_using_tsserver/
local organize_imports = function()
  local client = vim.lsp.get_clients({ name = 'ts_ls', bufnr = 0 })[1]

  client:exec_cmd({
    title = 'organize_imports',
    command = '_typescript.organizeImports',
    arguments = {
      vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
    },
  }, { bufnr = vim.api.nvim_get_current_buf() })
end
vim.api.nvim_create_user_command('OrganizeImports', organize_imports, {})

-- Setup TypeScript lsp
vim.lsp.config('ts_ls', {
  settings = {
    typescript = {
      tsserver = {
        enabled = true,
        maxTsServerMemory = 16384,
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Setup Mason
vim.lsp.config('*', {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
})

require('mason').setup()
-- Note: `nvim-lspconfig` needs to be in 'runtimepath' by the time you set up mason-lspconfig.nvim
require('mason-lspconfig').setup {
  ensure_installed = {
    'ts_ls',
    'lua_ls',
    'tailwindcss',
  },
  automatic_enable = {
    'ts_ls',
    'lua_ls',
  },
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
  formatting = {
    format = require('lspkind').cmp_format {
      before = require('tailwind-tools.cmp').lspkind_format,
    },
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

-- Require some commands from these files
require 'commands.format-enable'
require 'commands.format-disable'
require 'commands.copy-full-path'
require 'commands.copy-relative-path'
