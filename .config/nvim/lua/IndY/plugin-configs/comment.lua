-- Keybindings
-- C-/ to toggle comment in insert mode
vim.keymap.set("i", "<C-_>", "<Esc><Plug>(comment_toggle_current_linewise)gi")

-- Setup
require('Comment').setup{
	opleader = { -- LHS of Operator pending mode
		line = "gc",
		block = "gb"
	},

	toggler = { -- Toggle mapping LHS
		line = "gcc",
		block = "gbc"
	},

	mappings = {
		-- Basic mappings like gc[count]{motion} and gb[count]{motion} and ofc gcc and gbc
		basic = true,
		-- Extra mappings like gco, gcO, gcA
		extra = true,
		-- This includes g<, g> and others
		extended = true
	},

	pre_hook = function(ctx)
	-- This is used to calculate comment string befor commenting
    local U = require 'Comment.utils'

    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end

    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
  end,

	-- This is used to do things after commenting has been done like trimming, formatting etc
	post_hook = nil,

	-- Ignore certain lines can be Lua regex or a fun() that returns that
	ignore = "^$", -- Ignoring empty lines
}
