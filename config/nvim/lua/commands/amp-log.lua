-- View the Amp log file
return vim.api.nvim_create_user_command('AmpLog', function()
  local log_path = vim.fn.stdpath('cache') .. '/amp.log'
  if vim.fn.filereadable(log_path) == 1 then
    vim.cmd('split ' .. log_path)
  else
    vim.notify('Amp log file not found: ' .. log_path, vim.log.levels.WARN)
  end
end, {
  desc = 'View Amp log file',
})
