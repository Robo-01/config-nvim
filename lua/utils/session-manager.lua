local session_dir = vim.fn.stdpath("config") .. "/sessions/"
vim.fn.mkdir(session_dir, "p")

-- 💾 Save session (pick existing or type new)
vim.keymap.set("n", "<leader>ss", function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values

  local entries = vim.fn.globpath(session_dir, "*.vim", false, true)
  for i, path in ipairs(entries) do
    entries[i] = vim.fn.fnamemodify(path, ":t") -- just filename
  end

  table.insert(entries, 1, "[New Session]")

  pickers
    .new({}, {
      prompt_title = "Save session (overwrite or new)",
      finder = finders.new_table({ results = entries }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        map("i", "<CR>", function(prompt_bufnr)
          local entry = action_state.get_selected_entry().value
          actions.close(prompt_bufnr)

          local function save(name)
            local session_file = session_dir .. name .. ".vim"
            vim.cmd("mksession! " .. session_file)
            print("✅ Session saved to: " .. session_file)
          end

          if entry == "[New Session]" then
            vim.ui.input({ prompt = "Enter new session name: " }, function(input)
              if input and input ~= "" then
                save(input)
              else
                print("⚠️ Session name is required")
              end
            end)
          else
            local name = entry:gsub("%.vim$", "")
            save(name)
          end
        end)
        return true
      end,
    })
    :find()
end, { desc = "Save session (with overwrite option)" })
-- 🗑️ Telescope: List & delete session
vim.keymap.set("n", "<leader>sd", function()
  require("telescope.builtin").find_files({
    prompt_title = "Delete session",
    cwd = session_dir,
    attach_mappings = function(_, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      map("i", "<CR>", function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        local session_file = session_dir .. entry.value
        if vim.fn.delete(session_file) == 0 then
          print("🗑️ Session deleted: " .. session_file)
        else
          print("❌ Failed to delete session")
        end
      end)
      return true
    end,
  })
end, { desc = "Telescope: Pick and delete session" })
-- 🔍 Telescope: List & load session
vim.keymap.set("n", "<leader>sp", function()
  require("telescope.builtin").find_files({
    prompt_title = "Load session",
    cwd = session_dir,
    attach_mappings = function(_, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      map("i", "<CR>", function(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("source " .. session_dir .. entry.value)
        print("📂 Session loaded: " .. entry.value)
      end)
      return true
    end,
  })
end, { desc = "Telescope: Pick and load session" })
