-- Send a quick message to the agent
return vim.api.nvim_create_user_command('AmpSend', function(opts)
  local message = opts.args
  if message == '' then
    vim.ui.input({ prompt = 'Message to Amp: ' }, function(input)
      if input and input ~= '' then
        local amp_message = require 'amp.message'
        amp_message.send_message(input)
      end
    end)
    return
  end

  local amp_message = require 'amp.message'
  amp_message.send_message(message)
end, {
  nargs = '*',
  desc = 'Send a message to Amp',
})
