return {
	{
		"rockyzhang24/arctic.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		name = "arctic",
		branch = "v2",
		priority = 1000,
		config = function()
			-- vim.cmd("colorscheme arctic")
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
			})

			vim.cmd("colorscheme github_dark_dimmed")

			local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
			vim.api.nvim_set_hl(0, "StatusLine", { fg = 0x6cb6ff, bg = bg, bold = true })
			vim.api.nvim_set_hl(0, "StatusLineNC", { fg = 0x768390, bg = bg })
		end,
	},
}
