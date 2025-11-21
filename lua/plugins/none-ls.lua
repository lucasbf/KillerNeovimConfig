-- https://github.com/nvimtools/none-ls.nvim
return {
  {
    -- Hooks for LSP servers in neovim
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Lua
          null_ls.builtins.formatting.stylua,
          -- Python
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.diagnostics.mypy,
          -- C/C++
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.diagnostics.cppcheck,
          -- Latex
          -- null_ls.builtins.formatting.latexindent,
          -- HTML
          --null_ls.builtins.diagnostics.jinja_lsp,
          --null_ls.builtins.formatting.jinja_lsp,
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },
}
