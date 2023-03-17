local nvim = vim.api
local M = {}


M.get_all_tags = function()
  local handle = io.popen("rg --no-filename '^tags: \\['")
  -- local result = {}
  if handle == nil then
    return {}
  end

  local tags = {}
  for l in handle:lines() do
    for token in string.gmatch(l, "#%w+_?%w*") do
      tags[token] = true
    end
  end
  handle:close()

  local result = {}
  for tag, _ in pairs(tags) do
    table.insert(result, tag)
  end
  return result
end

return M
