local persist_file = vim.fn.stdpath("data") .. "/colorscheme.txt"

local function read_saved()
	local f = io.open(persist_file, "r")
	if f then
		local name = f:read("*l")
		f:close()
		if name and name ~= "" then
			return name
		end
	end
	return "github_dark_dimmed"
end

local function save_colorscheme(name)
	local f = io.open(persist_file, "w")
	if f then
		f:write(name)
		f:close()
	end
end

local function apply_statusline()
	local bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
	vim.api.nvim_set_hl(0, "StatusLine", { fg = 0x6cb6ff, bg = bg, bold = true })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = 0x768390, bg = bg })
end

return {
	{
		"rockyzhang24/arctic.nvim",
		dependencies = { "rktjmp/lush.nvim" },
		name = "arctic",
		branch = "v2",
		lazy = false,
		priority = 1000,
		config = function() end,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 999,
		config = function()
			require("github-theme").setup({})

			-- Reapply statusline overrides on every colorscheme change
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = apply_statusline,
			})

			-- :CS — open Telescope colorscheme picker and persist selection
			vim.api.nvim_create_user_command("CS", function()
				require("telescope.builtin").colorscheme({
					enable_preview = true,
					attach_mappings = function(_, map)
						local actions = require("telescope.actions")
						local action_state = require("telescope.actions.state")
						map("i", "<CR>", function(bufnr)
							local selected = action_state.get_selected_entry()
							actions.close(bufnr)
							if selected then
								vim.cmd("colorscheme " .. selected.value)
								save_colorscheme(selected.value)
							end
						end)
						map("n", "<CR>", function(bufnr)
							local selected = action_state.get_selected_entry()
							actions.close(bufnr)
							if selected then
								vim.cmd("colorscheme " .. selected.value)
								save_colorscheme(selected.value)
							end
						end)
						return true
					end,
				})
			end, { nargs = 0 })

			vim.keymap.set("n", "<leader>uc", "<cmd>CS<cr>", { desc = "Pick colorscheme" })

			vim.cmd("colorscheme " .. read_saved())
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
