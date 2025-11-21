-- https://github.com/nvim-treesitter/nvim-treesitter
return { 
  -- Treesitter configurations and abstraction layer for Neovim.
  "nvim-treesitter/nvim-treesitter", 
  build = ":TSUpdate",
  config = function() 
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {"lua", "cpp", "python"},
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
