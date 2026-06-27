vim.api.nvim_create_user_command("EditConfig", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/init.lua")
end, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
