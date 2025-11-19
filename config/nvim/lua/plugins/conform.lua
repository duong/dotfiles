-- Formatter format
return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform will run multiple formatters sequentially
      python = { 'isort', 'black' },
      cs = { 'csharpier', 'csharp_ls', stop_after_first = true },
      typescript = { 'dprint', 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'dprint', 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'dprint', 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'dprint', 'prettierd', 'prettier', stop_after_first = true },
      json = { 'fixjson', 'prettierd', 'prettier', stop_after_first = true }, -- fixjson is more compatible with vscode "JSON Language Features" formatter
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
    },
    formatters = {
      -- Temporary patch fix for chsharpier in conform.nvim
      -- patch from https://github.com/stevearc/conform.nvim/issues/699
      -- fix pr https://github.com/stevearc/conform.nvim/pull/695
      csharpier = function()
        local useDotnet = not vim.fn.executable 'csharpier'

        local command = useDotnet and 'dotnet csharpier' or 'csharpier'

        local version_out = vim.fn.system(command .. ' --version')

        -- vim.notify(version_out)

        --NOTE: system command returns the command as the first line of the result, need to get the version number on the final line
        local version_result = version_out[#version_out]
        local major_version = tonumber((version_out or ''):match '^(%d+)') or 0
        local is_new = major_version >= 1

        -- vim.notify(tostring(is_new))

        local args = is_new and { 'format', '$FILENAME' } or { '--write-stdout' }

        return {
          command = command,
          args = args,
          stdin = not is_new,
          require_cwd = false,
        }
      end,
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
