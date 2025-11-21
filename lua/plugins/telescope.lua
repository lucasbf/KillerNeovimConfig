-- https://github.com/nvim-telescope/telescope.nvim
return {
  {
    -- telescope.nvim is a highly extendable fuzzy finder over lists. 
    -- Built on the latest awesome features from neovim core. 
    -- Telescope is centered around modularity, allowing for easy customization.
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require("telescope").setup {
        defaults = {
          file_ignore_patterns = { "node_modules" }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }

          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
