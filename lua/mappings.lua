require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "n", "v", "t" }, "H", "<C-u>zz", { desc = "Move up" })
map({ "n", "v", "t" }, "L", "<C-d>zz", { desc = "Move down" })
map({ "n", "v", "t" }, "G", "Gzz", { desc = "Move down" })

map("n", "<leader>mv", "<C-v>", { desc = "Multi line visual mode" })
map("i", "jk", "<ESC>")
map("v", "<C-c>", "<ESC>")
map("i", "zz", "<ESC>zzs")

map("n", "<leader>vs", ":vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>hs", ":split<CR>", { desc = "Horizontal Split" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Remap navigation keys to use tmux navigator commands
map({ "n", "t" }, "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate Left" })
map({ "n", "t" }, "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate Down" })
map({ "n", "t" }, "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate Up" })
map({ "n", "t" }, "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate Right" })
map({ "n", "t" }, "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Navigate Previous" })

-- Yank to system clipboard using <leader>y
map({ "n", "t" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>Y", '"+yg_', { desc = "Yank line to system clipboard" })

map("x", "<leader>p", '"_dp', { desc = "Paste from system clipboard " })

map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Code Action
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

-- Remap <C-w> to double backslash
-- map("n", "\\", "<C-w>")
--
-- require("which-key").register({
--   ["\\"] = {
--     name = "+windows", -- shows up as a label
--     v = "Vertical Split",
--     s = "Horizontal Split",
--     c = "Close Window",
--     ["="] = "Equalize Splits",
--   },
-- }, { mode = "n" })
