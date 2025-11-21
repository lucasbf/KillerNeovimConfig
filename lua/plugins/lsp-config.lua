-- https://github.com/neovim/nvim-lspconfig
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        modifiable = true
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls", "pyright" },
        auto_install = true
      })
    end
  },
  {
    -- Language Server Protocol for NVIM
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.pyright.setup({
        capabilities = capabilities
      })
      lspconfig.clangd.setup({
        capabilities = capabilities
      })
      lspconfig.jinja_lsp.setup({
        capabilities = capabilities
      })
      -- Keymaps
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
