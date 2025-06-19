local M = {}

-- Separate states for terminal and image windows
local state = {
  terminal = {
    buf = nil,
    win = nil,
  },
  image = {
    buf = nil,
    win = nil,
  },
}

-- Create or reuse floating window
local function create_floating_window(opts)
  opts = opts or {}

  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf
  if opts.buf and type(opts.buf) == "number" and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
    if not buf or buf == 0 then
      error("Failed to create a valid buffer")
    end
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  if not win or win == 0 then
    error("Failed to create a valid floating window")
  end

  return { buf = buf, win = win }
end

function M.toggle_terminal()
  if state.terminal.win and vim.api.nvim_win_is_valid(state.terminal.win) then
    vim.api.nvim_win_hide(state.terminal.win)
    state.terminal.win = nil
  else
    local floating = create_floating_window({ buf = state.terminal.buf })
    state.terminal.buf = floating.buf
    state.terminal.win = floating.win

    if vim.bo[state.terminal.buf].buftype ~= "terminal" then
      vim.fn.termopen(vim.o.shell)
    end
    vim.api.nvim_set_current_win(state.terminal.win)
    vim.cmd("startinsert")
  end
end

function M.preview_image_floating(image_path)
  if state.image.win and vim.api.nvim_win_is_valid(state.image.win) then
    vim.api.nvim_win_close(state.image.win, true)
    state.image.win = nil
    state.image.buf = nil
  end

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)

  local floating = create_floating_window({ width = width, height = height })
  state.image.buf = floating.buf
  state.image.win = floating.win

  local inside_tmux = vim.env.TMUX ~= nil

  if inside_tmux then
    vim.fn.termopen({ "viu", "--transparent", image_path })
  else
    vim.fn.termopen({ "tmux", "new-session", "viu --transparent " .. image_path })
  end

  vim.api.nvim_set_current_win(state.image.win)
  vim.cmd("startinsert")
end

-- Auto resize support
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    if state.terminal.win and vim.api.nvim_win_is_valid(state.terminal.win) then
      vim.api.nvim_win_close(state.terminal.win, true)
      state.terminal.win = nil
      M.toggle_terminal()
    end
    if state.image.win and vim.api.nvim_win_is_valid(state.image.win) then
      vim.api.nvim_win_close(state.image.win, true)
      state.image.win = nil
    end
  end,
})

return M
