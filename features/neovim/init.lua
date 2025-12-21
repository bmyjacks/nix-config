-- ========================================================================== --
-- SETTINGS & OPTIONS
-- ========================================================================== --
local opt = vim.opt

opt.number = true           -- Show line numbers
opt.relativenumber = true   -- Relative line numbers for easier jumping
opt.mouse =              -- Disable mouse support
opt.ignorecase = true       -- Case-insensitive searching
opt.smartcase = true        -- ... unless search contains capitals
opt.hlsearch = false        -- Turn off highlight after search
opt.wrap = false            -- Don't wrap lines
opt.tabstop = 4             -- Insert 4 spaces for a tab
opt.shiftwidth = 4          -- Change the number of space characters inserted for indentation
opt.expandtab = true        -- Convert tabs to spaces
opt.termguicolors = true    -- True color support
opt.scrolloff = 8           -- Keep 8 lines above/below cursor
opt.signcolumn = "yes"      -- Always show the sign column (prevents flickering)

-- ========================================================================== --
-- KEYMAPS
-- ========================================================================== --
-- Set space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- Fast saving and quitting
keymap("n", "<leader>w", ":w<CR>", { desc = "Save" })
keymap("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Clear search highlights
keymap("n", "<Esc>", ":noh<CR>", { silent = true })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Indenting in visual mode (keeps selection)
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- ========================================================================== --
-- AUTOCOMMANDS
-- ========================================================================== --
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})
