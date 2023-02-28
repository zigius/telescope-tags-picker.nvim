local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local conf = require("telescope.config").values
local utils = require("telescope.utils")
local sorters = require("telescope.sorters")
local reload = require "plenary.reload"

return require("telescope").register_extension {
        exports = {
            list_tags = function(opts)
              opts = opts or {}

              pickers.new(opts, {
                  prompt_title = "tags",
                  finder = finders.new_table {
                      results = require "tags_picker_module".get_all_tags()
                  },
                  sorter = conf.generic_sorter(opts),
                  attach_mappings = function(prompt_bufnr, map)
                    actions.select_default:replace(function()
                      actions.close(prompt_bufnr)
                      local selection = action_state.get_selected_entry()
                      vim.api.nvim_put({ "'" .. selection[1] .. "'," }, "", false, true)
                    end)
                    return true
                  end,
              }):find()
            end
        }
    }
