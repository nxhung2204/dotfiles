return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	config = function()
		vim.opt.laststatus = 3
		-- Default splitting will cause your main splits to jump when opening an edgebar.
		-- To prevent this, set `splitkeep` to either `screen` or `topline`.
		vim.opt.splitkeep = "screen"

		require("edgy").setup({
			animate = {
				enabled = false,
			},

			left = {
				{
					title = "Files Explorer",
					ft = "NvimTree",
					size = { width = 0.25 },
				},
				{
					title = "Files changed",
					ft = "codediff-explorer",
				},
			},

			right = {
				{
					title = "Outline",
					ft = "aerial",
					size = { width = 0.25 },
				},
			},

			bottom = {
				{
					ft = "codediff-history",
					title = "Commit history",
					size = { height = 0.4 },
				},
			},
		})
	end,
}
