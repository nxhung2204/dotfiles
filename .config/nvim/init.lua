require("user.core.bootstrap_lazy")

-- nvim 0.11 requires User event patterns to be pre-registered before nvim_exec_autocmds can fire them
vim.api.nvim_create_autocmd("User", { pattern = "TelescopeFindPre", callback = function() end })

if vim.g.vscode then
	require("code.options")
	require("lazy").setup({
		spec = {
			{ import = "code.plugins" },
		},
		change_detection = { enabled = false },
	})
else
	require("lazy").setup({
		spec = {
			{ import = "user.plugins" },
		},
		change_detection = { enabled = false },
	})

	require("user.core")
end
