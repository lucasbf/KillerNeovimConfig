-- https://github.com/nvim-lualine/lualine.nvim
return {
  -- A blazing fast and easy to configure Neovim statusline written in Lua.
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        theme = 'dracula'
      }
    })
  end
}
