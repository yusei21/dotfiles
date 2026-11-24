-- Optional LazyVim plugin spec.
-- Copy this file to ~/.config/nvim/lua/plugins/minimal-glass.lua .
-- Reuses the existing LazyVim colorscheme; does not overwrite your nvim config.
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, _)
        hl.Normal = { bg = "NONE" }
        hl.NormalNC = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.FloatBorder = { fg = "#858b96", bg = "NONE" }
        hl.SignColumn = { bg = "NONE" }
        hl.LineNr = { fg = "#858b96", bg = "NONE" }
        hl.EndOfBuffer = { bg = "NONE" }
      end,
    },
  },
}
