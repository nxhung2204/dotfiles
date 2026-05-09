return {
	"pocco81/auto-save.nvim",
	event = "InsertLeave",
	opts = {
		enabled = true,
		execution_message = {
			message = function()
				return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
			end,
			cleaning_interval = 2000,
		},
	}
}
