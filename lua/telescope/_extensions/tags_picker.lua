local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local utils = require("telescope.utils")
local sorters = require("telescope.sorters")

return require("telescope").register_extension {
  exports = {
    list_tags = function(opts)
      opts = opts or {}

      local get_all_tags = function()

        local handle = io.popen("rg --no-filename '> tags:'")
        local result = {}
        for l in handle:lines() do
          for token in string.gmatch(l, "[^%s]+") do
            if token:find("#", 1, true) == 1 then
              table.insert(result, token .. " ")
            end
          end
        end
        handle:close()

        local hash = {}
        local dedup_res = {}

        for _,v in ipairs(result) do
           if (not hash[v]) then
               dedup_res[#dedup_res+1] = v -- you could print here instead of saving to result table if you wanted
               hash[v] = true
           end

        end
        return dedup_res
      end

      pickers.new(opts, {
        prompt_title = "tags",
        finder = finders.new_table {
          results = get_all_tags()
        },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.api.nvim_put({ selection[1] }, "", false, true)
          end)
          return true
        end,
      }):find()
    end
  }
}

-- > tags: #test
