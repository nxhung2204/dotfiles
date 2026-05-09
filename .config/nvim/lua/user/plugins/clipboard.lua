return {
	"ojroques/nvim-osc52",
	event = "VeryLazy",
	config = function()
		require("osc52").setup({
			max_length = 0,
			silent = false,
			trim = false,
		})

		vim.keymap.set("n", "<leader>cc", require("osc52").copy_operator, { expr = true })
		vim.keymap.set("v", "<leader>cc", require("osc52").copy_visual)
	end,
}
