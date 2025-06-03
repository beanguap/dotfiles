-- In ~/.config/nvim/lua/jeri/plugins/zellij.lua

return {
	"swaits/zellij-nav.nvim",
	config = function()
		require("zellij-nav").setup()
	end,
}
