return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot", -- lazy load khi chạy lệnh Copilot
		event = { "InsertEnter" }, -- hoặc giữ "InsertEnter", "CmdlineEnter" nếu bạn muốn
		config = function()
			require("copilot").setup({
				copilot_node_command = vim.fn.expand("~/.asdf/shims/node"),
				suggestion = {
					enabled = true,
					auto_trigger = true, -- giống auto_trigger cũ của bạn
					debounce = 75, -- giữ nguyên 75ms như cũ
					hide_during_completion = true, -- rất quan trọng nếu bạn dùng nvim-cmp
					trigger_on_accept = true,

					keymap = {
						accept = "<Tab>", -- giữ nguyên như cũ
						accept_word = "<C-Right>",
						accept_line = "<C-j>",
						next = "<C-n>",
						prev = "<C-p>",
						dismiss = "<C-c>",
						-- toggle_auto_trigger không có keymap mặc định, mình sẽ làm riêng bên dưới
					},
				},

				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom",
						ratio = 0.4,
					},
				},

				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false, -- tắt tất cả filetype khác trừ những cái bạn bật
				},

				-- Tùy chọn bổ sung (nên có)
				disable_limit_reached_message = true, -- giống config cũ của bạn
			})

			vim.keymap.set("n", "<leader>ct", function()
				local suggestion = require("copilot.suggestion")
				suggestion.toggle_auto_trigger()

				local is_auto = suggestion.is_auto_trigger_enabled()
				vim.notify("Copilot auto-trigger: " .. (is_auto and "ON" or "OFF"), vim.log.levels.INFO)
			end, { desc = "Toggle Copilot auto-trigger" })
		end,
	},
	{
		"folke/sidekick.nvim",
		opts = {
			nes = {
				enabled = true,
				diff = {
					inline = "words", -- hoặc "chars"
					show = "always",
				},
			},
			cli = {
				watch = true, -- auto reload file khi AI chỉnh sửa
				mux = {
					backend = "tmux", -- vì bạn dùng tmux
					enabled = true,
				},
				tools = {
					claude = {},
					gemini = {},
				},
				win = {
					keys = {},
				},
				session = {
					-- Tạo tên session dựa trên tên folder hiện tại (project root)
					name = function()
						local cwd = vim.fn.getcwd()
						return "sidekick-" .. vim.fn.fnamemodify(cwd, ":t") -- chỉ lấy tên folder
					end,
				},
			},
		},
		keys = {
			-- Tab để navigate/apply NES
			-- {
			-- 	"<tab>",
			-- 	function()
			-- 		if not require("sidekick").nes_jump_or_apply() then
			-- 			return "<Tab>" -- fallback
			-- 		end
			-- 	end,
			-- 	expr = true,
			-- 	mode = { "i", "n" },
			-- 	desc = "NES Jump/Apply",
			-- },

			-- {
			-- 	"<leader>aa",
			-- 	function()
			-- 		require("sidekick.cli").toggle()
			-- 	end,
			-- 	desc = "Toggle AI CLI",
			-- },
			{
				"<leader>as",
				function()
					require("sidekick.cli").select()
				end,
				desc = "Select Tool (Claude/Gemini...)",
			},
			{
				"<leader>ac",
				function()
					require("sidekick.cli").toggle({ name = "claude", focus = true })
				end,
				desc = "Open Claude",
			},
			{
				"<leader>ag",
				function()
					require("sidekick.cli").toggle({ name = "gemini", focus = true })
				end,
				desc = "Open Gemini",
			},

			{
				"<leader>at",
				function()
					require("sidekick.cli").send({ msg = "{this}" })
				end,
				mode = { "n", "x" },
				desc = "Send This",
			},
			{
				"<leader>af",
				function()
					require("sidekick.cli").send({ msg = "{file}" })
				end,
				desc = "Send File",
			},
		},
	},
}
