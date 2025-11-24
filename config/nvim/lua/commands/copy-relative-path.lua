return vim.api.nvim_create_user_command('CopyRelativePath', function()
  local path = vim.fn.fnamemodify(vim.fn.expand '%', ':.')
  vim.fn.setreg('+', path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {
  desc = 'Copy Relative Path to Clipboard',
})
