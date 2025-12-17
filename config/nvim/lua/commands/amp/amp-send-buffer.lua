-- Send entire buffer contents
return vim.api.nvim_create_user_command('AmpSendBuffer', function(opts)
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, '\n')

  local amp_message = require 'amp.message'
  amp_message.send_message(content)
end, {
  nargs = '?',
  desc = 'Send current buffer contents to Amp',
})
