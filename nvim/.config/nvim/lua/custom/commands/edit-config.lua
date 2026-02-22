vim.api.nvim_create_user_command("EditConfig", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, {})

