return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		indent = { enabled = true },
		scope = { enabled = true },
		gh = {},
		explorer = {
			enabled = true,
			hidden = true,
			win = {
				list = {
					wo = {
						number = true,
						relativenumber = true,
					},
				},
			},
		},
		image = {
			enabled = true,
			backend = "kitty",
			max_width_window_percentage = 95,
			max_height_window_percentage = 95,
			scale = 1.2,
		},
		input = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
			style = "compact",
			top_down = false,
		},
		picker = {
			enabled = true,
			layout = {
				preset = "dropdown",
				preview = false,
			},
			sources = {
				files = {
					hidden = true,
				},
				explorer = {
					hidden = true,
				},
			},
		},
		quickfile = { enabled = true },
		rename = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
	},
	keys = {
		-- Explorer
		{
			"<leader>e",
			function()
				Snacks.explorer()
				vim.defer_fn(function()
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
						if ft:match("^snacks") then
							vim.api.nvim_win_call(win, function()
								vim.cmd("normal! zz")
							end)
							break
						end
					end
				end, 100)
			end,
			desc = "File Explorer",
		},
		{
			"<leader>.",
			function()
				local file = vim.fn.expand("%:p")
				for _, win in ipairs(vim.api.nvim_list_wins()) do
					local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
					if ft:match("^snacks") then
						vim.api.nvim_set_current_win(win)
						vim.cmd("normal! zz")
						return
					end
				end
				Snacks.explorer({ reveal = file })
				vim.defer_fn(function()
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
						if ft:match("^snacks") then
							vim.api.nvim_win_call(win, function()
								vim.cmd("normal! zz")
							end)
							break
						end
					end
				end, 100)
			end,
			desc = "Reveal file in Explorer",
		},
		-- Picker (replacing telescope)
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>sr",
			function()
				Snacks.picker.recent({ filter = { cwd = true } })
			end,
			desc = "Find oldfiles",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Find branches",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find buffers",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Find current cursor",
			mode = { "n", "x" },
		},
		-- LSP (replacing aerial)
		{
			"<leader>uo",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		-- Notifications
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>um",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Show messages",
		},
		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues (open)",
		},
		{
			"<leader>gI",
			function()
				Snacks.picker.gh_issue({ state = "all" })
			end,
			desc = "GitHub Issues (all)",
		},
		{
			"<leader>gp",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub Pull Requests (open)",
		},
		{
			"<leader>gP",
			function()
				Snacks.picker.gh_pr({ state = "all" })
			end,
			desc = "GitHub Pull Requests (all)",
		},
	},
}
