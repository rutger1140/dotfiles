-- Default VIM configs
local opt = vim.opt -- mand

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Set tabs to 2 spaces
opt.tabstop = 2
opt.softtabstop = 2
opt.expandtab = true

-- Enable auto indenting and set it to spaces
opt.smartindent = true
opt.shiftwidth = 2

-- Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
opt.breakindent = true
opt.autoindent = true

-- Disable text wrapping
opt.wrap = false

-- Place a column line
opt.colorcolumn = "80"

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Cursor line
opt.cursorline = true

-- Enable mouse mode
opt.mouse = "a"

-- Save undo history
opt.undofile = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
opt.completeopt = { "menuone", "noselect" }

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.showtabline = 2 -- always show tabs

-- Always keep 8 lines above/below cursor unless at start/end of file
opt.scrolloff = 8

-- Backspace
opt.backspace = "indent,eol,start"

-- Split behavior
opt.splitright = true
opt.splitbelow = true

-- Set fold settings
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
-- opt.foldcolumn = "0"
-- opt.foldlevel = 99
-- opt.foldlevelstart = 99
-- opt.foldenable = true
--

-- Commented until Telescope is patched
-- https://github.com/nvim-telescope/telescope.nvim/issues/3436
-- opt.winborder = 'rounded'
