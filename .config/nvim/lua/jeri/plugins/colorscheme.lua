-- lua/plugins/colorscheme.lua  (Lazy.nvim style)
return {
	{
		"sainnhe/everforest",
		priority = 1000, -- load first
		lazy = false, -- don’t defer
		config = function()
			-- 1. Tell Vim we want a light UI
			vim.o.background = "light"

			-- 2. Everforest options BEFORE the colorscheme command
			vim.g.everforest_background = "soft" -- soft | medium | hard
			vim.g.everforest_enable_italic = true
			vim.g.everforest_disable_italic_comment = false
			vim.g.everforest_transparent_background = 0

			-- 3. Load the palette
			vim.cmd.colorscheme("everforest")

			-- 4. (Optional) tweak single highlights – keep them light-friendly
			-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#F2F1EC" })
		end,
	},
}
