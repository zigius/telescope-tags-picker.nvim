local M = {}
local reload = require "plenary.reload"

--[[ for test. do not remove
tags: ['#aws_lp_invent_and_simplify',]
--]]
M.test_get_all_tags = function()
  reload.reload_module("tags_picker_module")

  local get_all_tags = require "tags_picker_module".get_all_tags()
  print(vim.inspect(get_all_tags)) -- should print true

  local result = table.concat(get_all_tags) == table.concat({ "#newtag", "#vim", "#telescope" })
  return result
end

print(vim.inspect(M.test_get_all_tags())) -- should print true
return M
