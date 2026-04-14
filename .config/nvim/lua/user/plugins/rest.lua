return {
	-- Point to local directory during development
	dir = "/Users/rightsvn-hung/Dev/personal/restman.nvim",
	config = function()
		require("restman").setup({
			response_view = {
				default_view = "split",
			},
		})
	end,
}
