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
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim',
    },
  },
  { 'akinsho/toggleterm.nvim', version = '*', config = true },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  'ggandor/leap.nvim',
  'rrethy/vim-illuminate',
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = 'nvim-lua/plenary.nvim',
  },
  -- Uncomment to require specific config from kickstart
  -- require 'kickstart.plugins.debug',

  -- import all plugins from ./lua/plugins/*.lua
  { import = 'plugins' },
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
vim.api.nvim_set_keymap('n', '<leader>ut2', '<cmd>set shiftwidth=2 tabstop=2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ut4', '<cmd>set shiftwidth=4 tabstop=4<CR>', { noremap = true, silent = true })

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

-- [[ Configure toggleterm ]]
require('toggleterm').setup {}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

-- [[ Configure Comment ]]
require('ts_context_commentstring').setup {
  enable_autocmd = false,
}
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

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

-- Require some commands from these files
require 'commands.format-enable'
require 'commands.format-disable'

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
