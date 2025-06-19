require("nvchad.options")
require("utils.session-manager")

-- add yours here!

-- local o = vim.o
-- o.set("set relative number")

vim.opt.relativenumber = true

-- o.clipboard = "unnamedplus"
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.g.clipboard = {
  name = "xclip",
  copy = {
    ["+"] = "xclip -selection clipboard",
    ["*"] = "xclip -selection primary",
  },
  paste = {
    ["+"] = "xclip -selection clipboard -o",
    ["*"] = "xclip -selection primary -o",
  },
  cache_enabled = 0,
}

local floaterminal = require("utils.floaterminal")

-- Command to toggle generic floating terminal
vim.api.nvim_create_user_command("Floaterminal", floaterminal.toggle_terminal, {})

vim.keymap.set({ "n", "t" }, "<leader>tt", floaterminal.toggle_terminal, { desc = "Toggle Floating Terminal" })

-- Command to preview image in floating terminal with viu
vim.api.nvim_create_user_command("PreviewImage", function(opts)
  floaterminal.preview_image_floating(opts.args)
end, {
  nargs = 1,
  complete = "file",
})

-- Keybinding: <leader>i will prompt for image path and preview it with viu in floating terminal
vim.keymap.set("n", "<leader>i", function()
  vim.ui.input({ prompt = "Image path: " }, function(input)
    if input and input ~= "" then
      local path = vim.fn.fnamemodify(input, ":p") -- Convert to absolute path
      vim.cmd("PreviewImage " .. path)
    end
  end)
end, { desc = "Manually preview image with viu" })

vim.keymap.set("n", "<leader>o", function()
  -- Try to get a file path from under the cursor
  local raw = vim.fn.expand("<cfile>")

  -- Remove quotes (if any)
  local file = raw:gsub([["]], ""):gsub([[']], "")

  -- Convert to absolute path
  local abs_path = vim.fn.fnamemodify(file, ":p")

  -- Check if file actually exists
  if vim.fn.filereadable(abs_path) == 1 then
    vim.cmd("PreviewImage " .. vim.fn.fnameescape(abs_path))
  else
    print("No readable file found under cursor: " .. file)
  end
end, { desc = "Preview file under cursor with viu" })
