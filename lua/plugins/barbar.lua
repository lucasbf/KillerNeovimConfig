-- https://github.com/romgrk/barbar.nvim
return {
  -- Controls tab bars
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("barbar").setup {
      show_tab_indicators = true,
      show_close_icon = false,
      show_buffer_close_icons = false,
      show_buffer_icons = true,
      tab_size = 20,
      buffer_close_icon = "",
      mappings = true,
      buffer_icon_colors = true,
    }
  end,
}
