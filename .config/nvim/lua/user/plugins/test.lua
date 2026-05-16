return {
	{
		"vim-test/vim-test",
		ft = { "ruby" },
		dependencies = { "preservim/vimux" },
		keys = {
			{ "<leader>tc", "<cmd>TestNearest<cr>", desc = "Run Test at Cursor" },
			{ "<leader>tf", "<cmd>TestFile<cr>", desc = "Run File Tests" },
			{ "<leader>ta", "<cmd>TestSuite<cr>", desc = "Run Test Suite" },
			{ "<leader>tl", "<cmd>TestLast<cr>", desc = "Run Last Test" },
		},
		config = function()
			vim.g["test#strategy"] = "vimux"
			vim.g["VimuxOrientation"] = "h"
			vim.g["VimuxHeight"] = "33"
			vim.g["test#ruby#rails#executable"] = "bundle exec rails test"
			vim.g["test#ruby#minitest#executable"] = "bundle exec ruby -Itest"
		end,
	},
}
