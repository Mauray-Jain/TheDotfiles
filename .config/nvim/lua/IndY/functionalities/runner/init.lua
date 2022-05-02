local M = {}

function M.create_term(cmd)
	-- Check if toggleterm is there
	if packer_plugins["toggleterm.nvim"] then
		if packer_plugins["toggleterm.nvim"].loaded == false then
			vim.cmd [[ PackerLoad toggleterm.nvim ]]
		end
		local Terminal  = require('toggleterm.terminal').Terminal
		local get = require('toggleterm.config').get
		local repl = Terminal:new({
			cmd = cmd,
			hidden = true,
			close_on_exit = false,
			on_open = function (_)
				vim.cmd [[startinsert!]]
			end
		})
		repl:toggle(get("size"), get("direction"))
	else
		vim.notify("toggleterm.nvim not installed, using default terminal", vim.log.levels.WARN)
		vim.cmd([[split term://]]..cmd)
		vim.cmd [[startinsert!]]
	end
end

return M
