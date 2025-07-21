return vim.api.nvim_create_user_command('CopyFullPath', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {
  desc = 'Copy Full Path to Clipboard',
})
