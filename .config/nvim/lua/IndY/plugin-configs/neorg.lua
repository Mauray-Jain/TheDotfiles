require('neorg').setup {
	load = {
		-- The core module to get everything working
		["core.defaults"] = {},
		-- Icons > Text
		["core.norg.concealer"] = {},
		-- Auto-completion
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp"
			}
		},
		-- To export to different filetypes
		["core.export"] = {},
		-- Table of Contents
		["core.norg.qol.toc"] = {},
	}
}
