-- Add selected text directly to prompt
return vim.api.nvim_create_user_command('AmpPromptSelection', function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local text = table.concat(lines, '\n')

  local amp_message = require 'amp.message'
  amp_message.send_to_prompt(text)
end, {
  range = true,
  desc = 'Add selected text to Amp prompt',
})
