local amp_buf = nil

vim.api.nvim_create_user_command('AmpTerminalClose', function()
  if amp_buf and vim.api.nvim_buf_is_valid(amp_buf) then
    local job_id = vim.b[amp_buf].terminal_job_id
    if job_id then
      vim.fn.jobstop(job_id)
    end
    vim.api.nvim_buf_delete(amp_buf, { force = true })
    amp_buf = nil
    vim.notify('Amp terminal closed', vim.log.levels.INFO)
  else
    vim.notify('No Amp terminal found', vim.log.levels.WARN)
  end
end, { desc = 'Close Amp terminal cleanly' })

-- Open Amp in a terminal split
return vim.api.nvim_create_user_command('AmpTerminal', function(opts)
  -- If amp buffer exists and is valid
  if amp_buf and vim.api.nvim_buf_is_valid(amp_buf) then
    local win = vim.fn.bufwinid(amp_buf)
    if win ~= -1 then
      -- Visible: hide it
      vim.api.nvim_win_hide(win)
      return
    else
      -- Hidden: show it in a split
      local direction = opts.args ~= '' and opts.args or 'vertical'
      local size = 80
      if direction == 'vertical' or direction == 'v' then
        vim.cmd('rightbelow ' .. size .. 'vsplit')
      else
        vim.cmd('rightbelow ' .. (size / 4) .. 'split')
      end
      vim.api.nvim_set_current_buf(amp_buf)
      vim.cmd 'startinsert'
      return
    end
  end

  local direction = opts.args ~= '' and opts.args or 'vertical'
  local size = 80 -- default width for vertical, height for horizontal

  if direction == 'vertical' or direction == 'v' then
    vim.cmd('rightbelow ' .. size .. 'vsplit | terminal amp --ide')
  elseif direction == 'horizontal' or direction == 'h' then
    vim.cmd('rightbelow ' .. (size / 4) .. 'split | terminal amp --ide')
  else
    vim.notify('Usage: AmpTerminal [vertical|horizontal|v|h]', vim.log.levels.WARN)
    return
  end
  amp_buf = vim.api.nvim_get_current_buf()

  -- Clean up amp_buf when buffer is deleted (e.g., user closes window manually)
  vim.api.nvim_create_autocmd('BufDelete', {
    buffer = amp_buf,
    once = true,
    callback = function()
      amp_buf = nil
    end,
  })

  vim.cmd 'startinsert'
end, {
  nargs = '?',
  desc = 'Open Amp in a terminal split',
  complete = function()
    return { 'vertical', 'horizontal', 'v', 'h' }
  end,
})

