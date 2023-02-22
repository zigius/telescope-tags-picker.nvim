local M = {}
local reload = require "plenary.reload"

M.test_get_all_tags = function()
  reload.reload_module("tags_picker")

  local get_all_tags = require "tags_picker_module".get_all_tags()

  local result = table.concat(get_all_tags) == table.concat({ "#newtag", "#vim", "#telescope" })
  return result
end

vim.pretty_print(M.test_get_all_tags()) -- should print true
return M
