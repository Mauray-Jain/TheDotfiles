-- My key bindings
-- Remove Spacebar mapping so that I can make it the leader key
vim.keymap.set({"n", "v"}, "<Space>", "<Nop>")
vim.g.mapleader = " "
-- Editing Config file anytime needed
vim.keymap.set("n", "<Leader>ev", "<Cmd>edit $MYVIMRC<CR>")
-- Source the config file after edit
vim.keymap.set("n", "<Leader>sv", "<Cmd>source $MYVIMRC<CR>")
-- Indenting Lines
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
-- Moving Lines
vim.keymap.set("n", "<A-j>", [[<Cmd>m .+1<CR>==]])
vim.keymap.set("n", "<A-k>", [[<Cmd>m .-2<CR>==]])
vim.keymap.set("v", "<A-j>", [[:'<,'>m '>+1<CR>gv=gv]])
vim.keymap.set("v", "<A-k>", [[:'<,'>m '<-2<CR>gv=gv]])
vim.keymap.set("i", "<A-j>", [[<Cmd>m .+1<CR><Cmd>normal! ==gi<CR>]])
vim.keymap.set("i", "<A-k>", [[<Cmd>m .-2<CR><Cmd>normal! ==gi<CR>]])
-- Pasting on top of selected text without saving the selected text
vim.keymap.set("v", "p", [["_dP]])
-- Remove highlighting after searching
vim.keymap.set("n", "<Leader><Leader>", "<Cmd>noh<CR>")
-- Windows' shortcuts
vim.keymap.set("n", "<Leader>wj", "<C-w>j")
vim.keymap.set("n", "<Leader>wk", "<C-w>k")
vim.keymap.set("n", "<Leader>wl", "<C-w>l")
vim.keymap.set("n", "<Leader>wh", "<C-w>h")
vim.keymap.set("n", "<C-k>", "<C-w>+") -- Increase height
vim.keymap.set("n", "<C-j>", "<C-w>-") -- Decrease height
vim.keymap.set("n", "<C-h>", "<C-w><") -- Decrease width
vim.keymap.set("n", "<C-l>", "<C-w>>") -- Increase width
-- Plugin Management [<Leader>p - Packer]
vim.keymap.set("n", "<Leader>ps", "<Cmd>PackerSync<CR>")
-- C-/ to toggle comment in insert mode
vim.keymap.set("i", "<C-_>", "<Esc><Plug>(comment_toggle_current_linewise)gi")
-- Nvim-Tree Management [<Leader>n - Nvim-tree]
vim.keymap.set("n", "<Leader>n", "<Cmd>NvimTreeToggle<CR>")
-- Telescope Management [<Leader>f - find]
vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<Leader>fo", "<Cmd>Telescope oldfiles<CR>")
vim.keymap.set("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>")
vim.keymap.set("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader>fr", "<Cmd>Telescope registers<CR>")
vim.keymap.set("n", "<Leader>fd", function ()
	-- Search Dotfiles with Telescope in any directory
	require("telescope.builtin").find_files({
		prompt_title = "< VimRC >",
		cwd = "~/repo/TheDotfiles/nvim",
	})
end)
-- Navigate through buffers [<Leader>b - buffers]
vim.keymap.set("n", "<Leader>bn", "<Cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<Leader>bp", "<Cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<Leader>bc", "<Cmd>BufferLinePick<CR>")
vim.keymap.set("n", "<Leader>bx", "<Cmd>NvimTreeClose<CR><Cmd>bwipeout<CR>")
-- Move the current buffer backwards or forwards in the bufferline
vim.keymap.set("n", "<Leader>bbn", "<Cmd>BufferLineMoveNext<CR>")
vim.keymap.set("n", "<Leader>bbp", "<Cmd>BufferLineMovePrev<CR>")
-- Sort buffers by directory, language, or a custom criteria
-- vim.keymap.set("n", "<Leader>be", "<Cmd>BufferLineSortByExtension<CR>")
-- vim.keymap.set("n", "<Leader>bd", "<Cmd>BufferLineSortByDirectory<CR>")
-- vim.keymap.set("n", "<Leader>bbc", function ()
-- 	require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)
-- end)

-- Some general settings, see :h[elp] options
vim.g.python3_host_prog = "/usr/sbin/python"
vim.opt.termguicolors = true
vim.opt.number = true -- Pretty obvious
vim.opt.relativenumber = true -- Obvious again
vim.opt.mouse = "a" -- Make the screen clickable
vim.opt.tabstop = 2 -- Convert tab into 2 spaces
vim.opt.shiftwidth = 2 -- Convert tab into 2 spaces
vim.opt.smartindent = true -- Self explanatory
vim.opt.writebackup = true -- Make a backup file
vim.opt.backup = false -- After making backup file delete it after writing successfully
vim.opt.splitbelow = true -- Split Below
vim.opt.splitright = true -- Split Right
vim.opt.signcolumn = "yes" -- Sign column is important
vim.opt.scrolloff = 8 -- Keep atleast 8 lines above and below the cursor
vim.opt.laststatus = 3 -- Keep a single statusline for all windows
vim.g.markdown_fenced_languages = { -- For deno lsp server
  "ts=typescript"
}

-- Autocommands
local settingsGroup = vim.api.nvim_create_augroup("Settings", {clear = true})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = settingsGroup,
	desc = "Highlight on yank",
	pattern = "*",
	callback = function() vim.highlight.on_yank({higroup = "Incsearch", timeout = 150, on_visual = true}) end
})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = settingsGroup,
	desc = "Autocommand that updates, installs and removes plugins whenever you save the plugins.lua file",
	pattern = "plugins.lua",
	command = "source <afile> | PackerSync"
})

require('IndY.plugins')
require('IndY.plugin-configs.lsp.lsp-config')
-- require('IndY.statusline')
