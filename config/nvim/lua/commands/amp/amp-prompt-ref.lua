-- Add file+selection reference to prompt
return vim.api.nvim_create_user_command('AmpPromptRef', function(opts)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    print 'Current buffer has no filename'
    return
  end

  local relative_path = vim.fn.fnamemodify(bufname, ':.')
  local ref = '@' .. relative_path
  if opts.line1 ~= opts.line2 then
    ref = ref .. '#L' .. opts.line1 .. '-' .. opts.line2
  elseif opts.line1 > 1 then
    ref = ref .. '#L' .. opts.line1
  end

  local amp_message = require 'amp.message'
  amp_message.send_to_prompt(ref)
end, {
  range = true,
  desc = 'Add file reference (with selection) to Amp prompt',
})
