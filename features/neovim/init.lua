-- ========================================================================== --
-- SETTINGS & OPTIONS
-- ========================================================================== --
local opt = vim.opt

opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers for easier jumping
opt.mouse = "" -- Disable mouse support
opt.ignorecase = true -- Case-insensitive searching
opt.smartcase = true -- ... unless search contains capitals
opt.hlsearch = false -- Turn off highlight after search
opt.wrap = false -- Don't wrap lines
opt.tabstop = 4 -- Insert 4 spaces for a tab
opt.smartindent = true -- Insert indents automatically in some cases
opt.autoindent = true -- Copy indent from current line when starting a new line
opt.shiftwidth = 4 -- Change the number of space characters inserted for indentation
opt.expandtab = true -- Convert tabs to spaces
opt.termguicolors = true -- True color support
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.signcolumn = "yes" -- Always show the sign column (prevents flickering)

-- Themes
require("onedark").load()
require("lualine").setup({
	options = {
		theme = "onedark",
	},
	sections = {
		lualine_x = {
			function()
				return os.getenv("DIRENV_DIFF") ~= nil and "inDIRenv" or ""
			end,
			"encoding",
			"fileformat",
			"filetype",
		},
	},
})

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

-- Diagnostics messages
vim.diagnostic.config({
	virtual_text = {
		prefix = ">",
		spacing = 8,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Formatter
require("conform").setup({
	formatters_by_ft = {
		-- Use "_" to define a fallback formatter for all filetypes
		-- if a specific one isn't found
		["_"] = function(bufnr)
			if vim.fn.executable("treefmt") == 1 then
				return { "treefmt" }
			end
			return {}
		end,
	},
})
vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (Treefmt)" })

-- File explorer
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Treesitter
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true }, -- This is the magic line for "smart" indents
})

-- Auto cmp
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},

	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- Trigger menu manually
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept completion
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- Set up lspconfig.
local servers = { "lua_ls", "nixd", "gopls" }

for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, {
		capabilities = capabilities,
	})
	vim.lsp.enable(lsp)
end
