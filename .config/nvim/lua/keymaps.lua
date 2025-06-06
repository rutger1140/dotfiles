-- Key mappings
--
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Change leader to space
vim.g.mapleader = " "

-- Disable swapfile
vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Save text to clipboard in visual mode by hitting ctrl-c
map("v", "<C-c>", ":w !pbcopy<CR><CR>", opts)

-- Move single line up in normal mode
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("n", "<A-Down>", ":m .+1<CR>==", opts)

-- Move multiple lines in visual mode
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- -- Move to previous/next
map("n", "<A-.>", ":BufferLineCycleNext<CR>", opts)
map("n", "<A-,>", ":BufferLineCyclePrev<CR>", opts)

-- -- Re-order to previous/next
-- map("n", "<A-<>", ":BufferMovePrevious<CR>", opts)
-- map("n", "<A->>", ":BufferMoveNext<CR>", opts)
--
