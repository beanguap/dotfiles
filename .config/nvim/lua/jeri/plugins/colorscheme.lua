return {
  {
    "sainnhe/everforest",
    priority = 1000,
    config = function()
      -- Set the Everforest background and other options BEFORE loading the theme
      vim.g.everforest_background = "hard" -- or "medium", "soft"
      vim.g.everforest_enable_italic = true
      vim.g.everforest_disable_italic_comment = false
      vim.g.everforest_transparent_background = 0 -- set to 1 if you want transparency

      -- Custom color overrides via highlight groups
      vim.cmd([[colorscheme everforest]])

      -- Now override specific highlight groups with your custom colors
      vim.api.nvim_set_hl(0, "Normal", { bg = "#011628", fg = "#CBE0F0" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "#275378" })
      vim.api.nvim_set_hl(0, "Search", { bg = "#0A64AC", fg = "#000000" })
      vim.api.nvim_set_hl(0, "StatusLine", { bg = "#011423", fg = "#CBE0F0" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "#627E97" })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#547998", bg = "#011423" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#011423" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "#143652" })
    end,
  },
}

