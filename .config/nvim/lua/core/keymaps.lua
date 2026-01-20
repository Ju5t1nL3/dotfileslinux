-- [[ Basic Keymaps ]]

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show full diagnostic message' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover.
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Override Ctrl-d to always scroll half page, ignoring any numbers (counts) typed before
vim.keymap.set("n", "<C-d>", function()
	vim.cmd("normal! \x04") -- \x04 is the internal code for Ctrl-d
	vim.cmd("normal! zz")
end, { desc = "Scroll down half page (ignore count)" })

-- Override Ctrl-u to always scroll half page, ignoring any numbers (counts) typed before
vim.keymap.set("n", "<C-u>", function()
	vim.cmd("normal! \x15") -- \x15 is the internal code for Ctrl-u
	vim.cmd("normal! zz")
end, { desc = "Scroll up half page (ignore count)" })
